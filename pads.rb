# Given a features file for a layer, parse all pads.

require 'json'

class Parseable
  REGEX = nil

  def self.parse(file_lines)
    raise "No regex defined" if regex.nil?

    matches = file_lines.map do |line|
      match_data = regex.match(line)
      match_data_to_hash(match_data) if match_data
    end

    matches.delete_if &:nil?
  end

  private

    def self.regex
      self::REGEX
    end

    def self.match_data_to_hash(match_data)
      match_data.names.zip(match_data.captures).to_h
    end
end

class Symbol
  def initialize(type, params)
    @type = type
    @params = params
  end

  def self.from_symbol_name(symbol_name)

  end
end

class FeatureSymbolName < Parseable
  REGEX = /^\$(?<serial_num>\d*) (?<symbol_name>[[:alnum:]]*)( (?<measurements>I|M))?$/

  def self.parse_symbols(file_lines)
    parse(file_lines).map do |match_data_hash|
      Symbol.from_symbol_name(match_data_hash['symbol_name'])
    end
  end
end

class Feature < Parseable
end

class Pad < Feature
  REGEX = /^P (?<x>\d.\d*) (?<y>\d.\d*) (?<apt_def>\d) (?<polarity>P|N) (?<dcode>\d) (?<orient_def>\d)( (?<rotation>\d{0,3}))?;(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/

  def initialize(match_data_hash)
    @match_data_hash = match_data_hash
  end

  def self.parse_pads(file_lines)
    parse(file_lines).map do |match_data_hash|
      new(match_data_hash)
    end
  end

  def describe(feature_symbol_names)
    symbol_name_index = @match_data_hash['apt_def'].to_i
    feature_symbol_name = feature_symbol_names[symbol_name_index]
    symbol = feature_symbol_name['symbol_name']

    {
      :id => @match_data_hash['id'],
      :symbol => symbol,
      :x => @match_data_hash['x'],
      :y => @match_data_hash['y']
    }
  end
end

def main
  file_lines = File.read("sample_features").lines

  pads = Pad::parse_pads(file_lines)
  feature_symbol_names = FeatureSymbolName::parse(file_lines)

  output = {
    :pads => pads.map { |pad| pad.describe(feature_symbol_names) }
  }

  puts JSON.dump(output)
end

main