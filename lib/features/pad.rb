# Given a features file for a layer, parse all pads.

require 'json'
require_relative '../parseable.rb'

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