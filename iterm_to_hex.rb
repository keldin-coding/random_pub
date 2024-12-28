#!/usr/bin/env ruby

# To use me:
# in iTerm, go to Settings -> Profile -> Colors tab -> Color presets dropdown -> Export...
# cat <the file you just exported> | ./iterm_to_hex.rb
#
# The ghostty config format will be printed on screen to be copy-pasted to your config

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'nokogiri'
end


PARSINGS = {
  /^Ansi (\d+) Color$/ => -> (color_num) { "palette = #{color_num}=%s" },
  /^Background Color$/ => -> (_) { "background = %s" },
  /^Foreground Color$/ => -> (_) { "foreground = %s"},
  /^Selection Text Color$/ => -> (_) { "selection-foreground = %s"},
  /^Selection Color$/ => -> (_) { "selection-background = %s"},
  /^Cursor Color$/ => -> (_) { "cursor-color = %s" },
}

color_values = []

doc = Nokogiri::XML(ARGF.read)

root_dict = doc.xpath("./plist/dict")

def color_to_hex_code(color)
  color = color.to_f

  (color * 255).floor.to_s(16).ljust(2, "0")
end

root_dict.children.reject(&:text?).each_slice(2) do |key, color_dictionary|
  pattern, value_proc = PARSINGS.find { |pattern, _| pattern.match?(key.content) }

  next if !pattern

  matches = pattern.match(key.content)

  color_data = {red: nil, blue: nil, green: nil}

  color_dictionary.children.reject(&:text?).each_slice(2) do |key, value|
    case key.content
    when "Blue Component" then color_data[:blue] = color_to_hex_code(value.content)
    when "Red Component" then color_data[:red] = color_to_hex_code(value.content)
    when "Green Component" then color_data[:green] = color_to_hex_code(value.content)
    end
  end

  color_str = "#{color_data[:red]}#{color_data[:green]}#{color_data[:blue]}"

  color_values << (value_proc.call(matches[1]) % color_str)
end

puts color_values
