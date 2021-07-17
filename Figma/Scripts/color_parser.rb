require 'json'

file = File.read('./color_styles.json')
color_styles = JSON.parse(file, object_class: OpenStruct)

colors = color_styles.compact.filter { |style| style.paints.first.color != nil }.map { |style|
  isDark = style.name.include? "Dark"
  
  {
    "id" => style.id,
    "name" => style.name.gsub(" ", "").gsub("-", "").gsub("/", ".").downcase.capitalize(),
    "is_dark" => isDark,
    "r" => style.paints.first.color.r,
    "g" => style.paints.first.color.g,
    "b" => style.paints.first.color.b
  } 
}.flatten

File.write("./generated_colors.json", JSON.pretty_generate(colors))