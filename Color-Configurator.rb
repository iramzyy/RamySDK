require 'json'
require 'pp'

def hex_color_to_rgba(hex, opacity)
  rgb = hex.match(/^#(..)(..)(..)$/).captures.map(&:hex)
  return rgb + [opacity]
end

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

file = File.read('./Colors-Config.json')
colors = JSON.parse(file, object_class: OpenStruct)

colors.each { |color|
  color.types.each { |sub_color|
    content_json_path = "#{color.assets_path}/#{color.type}.#{sub_color.type}.colorset/Contents.json"
    assets_color_json = JSON.parse(File.read(content_json_path), :quirks_mode => true, object_class: OpenStruct)
    assets_color_json.colors.each { |asset_color|
      unless asset_color.appearances.nil?
        rgb = hex_color_to_rgba(sub_color.dark, 1)
        asset_color.color.components.red = "#{rgb[0]}"
        asset_color.color.components.green = "#{rgb[1]}"
        asset_color.color.components.blue = "#{rgb[2]}"
      else
        rgb = hex_color_to_rgba(sub_color.light, 1)
        asset_color.color.components.red = "#{rgb[0]}"
        asset_color.color.components.green = "#{rgb[1]}"
        asset_color.color.components.blue = "#{rgb[2]}"
      end
    }
    File.write(content_json_path, JSON.pretty_generate(open_struct_to_hash(assets_color_json)))
  }
}
