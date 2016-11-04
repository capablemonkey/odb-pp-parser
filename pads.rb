# Given a features file for a layer, parse all pads.

require 'json'

PAD_REGEX = /^P (?<x>\d.\d*) (?<y>\d.\d*) (?<apt_def>\d) (?<polarity>P|N) (?<dcode>\d) (?<orient_def>\d)( (?<rotation>\d{0,3}))?;(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/

def parse_pads
  pads = File.read("sample_features").lines.map do |line|
    # puts line if PAD_REGEX =~ line
    match_data = PAD_REGEX.match(line)
    if match_data
      match_data_to_hash(match_data)
    end
  end

  pads.delete_if &:nil?
end

def match_data_to_hash(match_data)
  match_data.names.zip(match_data.captures).to_h
end

def describe_pad(pad)
  {
    :id => pad['id'],
    :x => pad['x'],
    :y => pad['y']
  }
end

def main
  pads = parse_pads
  output = {
    :pads => pads.map { |pad| describe_pad(pad) }
  }

  puts JSON.dump(output)
end

main