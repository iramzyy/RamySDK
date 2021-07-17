require 'json'
require 'pp'
require 'FileUtils'
require 'Xcodeproj'
require 'nokogiri'
require 'nokogiri-plist'

$fonts_json = JSON.parse(File.read('./Fonts-Config.json'), object_class: OpenStruct)

def open_struct_to_hash(object, hash = {})
  object.each_pair do |key, value|
    hash[key] = case value
                  when OpenStruct then open_struct_to_hash(value)
                  when Array then value.map { |v| open_struct_to_hash(v) }
                  else value
                end
  end
  hash
end

def recursive_children_groups(groups)
  result = []
  groups.each do |child|
    result << child
    result.concat(child.recursive_children_groups)
  end
  result
end

def get_group(groupName, groups)
  return recursive_children_groups(groups).find { |group|
    group.path == groupName
  }
end

def add_font_group_files(project)
  font_group = get_group("Fonts", project.groups)
  font_families_group = get_group("Families", project.groups)

  info_plist_file_ref = project.files.find { |file| file.display_name == "Info.plist"}.real_path
  supported_weights = $fonts_json.supported_weights
  info_plist = Nokogiri::PList(open(info_plist_file_ref))

  pp "Removing all existing fonts in Families group"
  font_families_group.files.each do |file|
    pp "Removing #{file.display_name}..."
    file.remove_from_project
    FileUtils.rm_rf file.path
  end
  font_families_group.groups.each do |group|
    pp "Removing #{group.display_name}..."
    group.remove_from_project
  end

  if info_plist.has_key? "UIAppFonts" and info_plist["UIAppFonts"].empty? == false
    pp "Removing All Fonts in Plist"
    info_plist["UIAppFonts"].clear
  end

  pp "Removing Fonts from Build Phases Resources Step"
  supported_weights.each { |weight|
    project.targets.first.resources_build_phase.files.each { |file|
      if file.display_name.end_with?("-#{weight}.ttf")
        pp "Deleting #{file.display_name} from Resources..."
        file.remove_from_project
      end
    }
  }

  $fonts_json.fonts.each { |font|
    font_family = font.family
    destination = "#{font_families_group.real_path}/#{font.family}"

    pp "Checking if Destination's group exists"
    if project.groups.any? { |g| g.display_name == font.family } == false
      pp "Creating a group for #{font.family}"
      family_group = font_families_group.new_group(font.family)
      FileUtils.mkdir_p destination
    else
      family_group = get_group(font.family, project.groups)
    end


    Dir.each_child("#{$fonts_json.source}/#{font.family}") { |child|
      if supported_weights.any? { |weight| child.end_with?("-#{weight}.ttf") || child.end_with?("-#{weight}.otf") }
        pp "Adding #{child} to #{font_family}"
        if child.end_with? "ttf"
          FileUtils.cp "#{$fonts_json.source}/#{font.family}/#{child}", "#{destination}/#{child}"
          file_ref = family_group.new_file("#{font_families_group.real_path}/#{font.family}/#{child}")
          pp "Adding #{child} to Resources"
          project.targets.first.add_resources([file_ref])
          pp "Adding #{child} to Info.plist"
          if info_plist.has_key?("UIAppFonts")
            info_plist["UIAppFonts"].push child
          else
            info_plist["UIAppFonts"] = [child]
          end
        elsif child.end_with? "otf"
          pp "You should use tff because its better for Apple Env"
          FileUtils.cp "#{$fonts_json.source}/#{font.family}/#{child}", "#{destination}/#{child}"
          file_ref = family_group.new_file("#{font_families_group.real_path}/#{font.family}/#{child}")
          pp "Adding #{child} to Resources"
          project.targets.first.add_resources([file_ref])
          pp "Adding #{child} to Info.plist"
          if info_plist.has_key?("UIAppFonts")
            info_plist["UIAppFonts"].push child
          else
            info_plist["UIAppFonts"] = [child]
          end
        end
      end
    }
  }

  pp "Saving Info.plist to Project"
  File.open(info_plist_file_ref, 'w') { |info_plist_file| info_plist_file.write(info_plist.to_plist_xml) }

  font_group.files.each do |file|
    if file.display_name == "fonts.json"
      pp "Found an old fonts.json, Replacing it with the new one."
      file.remove_from_project
      FileUtils.rm_rf file.path
    end
  end

  configuration_json = File.write("#{font_group.real_path}/fonts.json", JSON.pretty_generate({ :fonts => $fonts_json.fonts.map { |e| open_struct_to_hash(e) }, :default_configurations => open_struct_to_hash($fonts_json.default_configurations) }))
  file_ref = font_group.new_file("#{font_group.real_path}/fonts.json")
  project.targets.first.add_resources([file_ref])

  project.targets.first.resources_build_phase.files.each { |file|
    if file.display_name == "BuildFile"
      pp "Deleting #{file.display_name}..."
      file.remove_from_project
    end
  }
end

project = Xcodeproj::Project.open($fonts_json.project_path)
add_font_group_files(project)

project.save()
