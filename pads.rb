# Given a features file for a layer, parse all pads.

require 'json'

PAD_REGEX = /^P (?<x>\d.\d*) (?<y>\d.\d*) (?<apt_def>\d) (?<polarity>P|N) (?<dcode>\d) (?<orient_def>\d)( (?<rotation>\d{0,3}))?;(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/
FEATURE_SYMBOL_NAMES_REGEX = /^\$(?<serial_num>\d*) (?<symbol_name>[[:alnum:]]*)( (?<measurements>I|M))?$/

def parse_pads(file_lines)
  pads = file_lines.map do |line|
    match_data = PAD_REGEX.match(line)
    match_data_to_hash(match_data) if match_data
  end

  pads.delete_if &:nil?
end

def parse_feature_symbol_names(file_lines)
  feature_symbol_names = file_lines.map do |line|
    match_data = FEATURE_SYMBOL_NAMES_REGEX.match(line)
    match_data_to_hash(match_data) if match_data
  end

  feature_symbol_names.delete_if &:nil?
end

def match_data_to_hash(match_data)
  match_data.names.zip(match_data.captures).to_h
end

def describe_pad(pad, feature_symbol_names)
  symbol_name_index = pad['apt_def'].to_i
  feature_symbol_name = feature_symbol_names[symbol_name_index]
  symbol = feature_symbol_name['symbol_name']

  {
    :id => pad['id'],
    :symbol => symbol,
    :x => pad['x'],
    :y => pad['y']
  }
end

def main
  file_lines = File.read("sample_features").lines

  pads = parse_pads(file_lines)
  feature_symbol_names = parse_feature_symbol_names(file_lines)

  output = {
    :pads => pads.map { |pad| describe_pad(pad, feature_symbol_names) }
  }

  puts JSON.dump(output)
end

main