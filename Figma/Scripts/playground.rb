require 'json'
require 'hashie'

class Hash
    def to_o
        JSON.parse to_json, object_class: OpenStruct
    end
end


# def get_style_properties(style)
#     return style.name.split(",").map { |word| word.split("=") }.to_h.transform_keys{ |key| key.gsub(" ", "").downcase }.to_o
# end

# def get_color(color_id)
#     color = $color_styles.find { |style| style.id == color_id }
#     if color == nil 
#         return nil 
#     end
#     color.name = color.name.gsub(" ", "").gsub("-", "").gsub("/", ".").downcase.capitalize()
#     return color.to_h
# end

# def get_color_ids(style)
#     return {
#         "background" => style.fillStyleId,
#         "border" => style.strokeStyleId,
#         "text" => style.children.find { |child| child.type == "TEXT" }.fillStyleId,
#         "icon" => style.children.find { |child| child.type == "TEXT" }.fillStyleId,
#     }.to_o
# end

# def get_style_required_data(style)
#     properties = get_button_properties(style)
#     colors = get_color_ids(style)
#     return {
#         "type" => properties.type,
#         "state" => properties.state,
#         "size" => properties.size,
#         "radius" => properties.radius,
#         "background_color" => get_color(colors.background),
#         "border_color" => get_color(colors.border),
#         "text_color" => get_color(colors.text),
#         "icon_color" => get_color(colors.icon)
#     }
# end

file = File.read('../Styles/textfield_styles.json')
json = JSON.parse(file)

json.extend Hashie::Extensions::DeepLocate

caption_json = json.deep_locate -> (key, value, object) { key == "name" && value == "Uh oh! There was an error!" }
close_button_json = json.deep_locate -> (key, value, object) { key == "name" && value == "Close" }
placeholder_json = json.deep_locate -> (key, value, object) { key == "name" && value == "Phone Number" }
text_json = json.deep_locate -> (key, value, object) { key == "name" && value == "999-999-999" }
body_json = json.deep_locate -> (key, value, object) { key == "name" && value == "Input" }


caption = { 
    "name" => get_color
    "text_color" => get_color(caption_json.to_o.fillStyleId)
}


File.write('../Generated/generated_playground.json', JSON.pretty_generate(
        {
            "caption" => caption,
            "close_button" => close_button,
            "placeholder" => placeholder,
            "text" => text,
            "body" => body
        }
    )
)