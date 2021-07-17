require 'json'

class Hash
    def to_o
        JSON.parse to_json, object_class: OpenStruct
    end
end

$button_styles_file = File.read('../Styles/button_styles.json')
$button_styles = JSON.parse($button_styles_file, object_class: OpenStruct)

$color_styles_file = File.read('../Generated/generated_colors.json')
$color_styles = JSON.parse($color_styles_file, object_class: OpenStruct)

def get_button_properties(style)
    return style.name.split(",").map { |word| word.split("=") }.to_h.transform_keys{ |key| key.gsub(" ", "").downcase }.to_o
end

def get_color(color_id)
    color = $color_styles.find { |style| style.id == color_id }
    if color == nil 
        return nil 
    end
    color.name = color.name.gsub(" ", "").gsub("-", "").gsub("/", ".").downcase.capitalize()
    return color.to_h
end

def get_color_ids(style)
    return {
        "background" => style.fillStyleId,
        "border" => style.strokeStyleId,
        "text" => style.children.find { |child| child.type == "TEXT" }.fillStyleId,
        "icon" => style.children.find { |child| child.type == "TEXT" }.fillStyleId,
    }.to_o
end

def get_style_required_data(style)
    properties = get_button_properties(style)
    colors = get_color_ids(style)
    return {
        "type" => properties.type,
        "state" => properties.state,
        "size" => properties.size,
        "radius" => properties.radius,
        "background_color" => get_color(colors.background),
        "border_color" => get_color(colors.border),
        "text_color" => get_color(colors.text),
        "icon_color" => get_color(colors.icon)
    }
end

buttons = $button_styles.filter { |style| style != nil }.compact.map { |style| 
    get_style_required_data(style)
}

File.write("./generated_primary_buttons_styles.json", JSON.pretty_generate(buttons.filter { |button| button["type"] == "Primary" }))
File.write("./generated_secondary_buttons_styles.json", JSON.pretty_generate(buttons.filter { |button| button["type"] == "Secondary" }))
File.write("./generated_subtle_buttons_styles.json", JSON.pretty_generate(buttons.filter { |button| button["type"] == "Subtle" }))
File.write("./generated_text_buttons_styles.json", JSON.pretty_generate(buttons.filter { |button| button["type"] == "Text" }))

