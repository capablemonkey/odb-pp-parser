class Pad < Parseable
  REGEX = /^P (?<x>\d.\d*) (?<y>\d.\d*) (?<apt_def>\d) (?<polarity>P|N) (?<dcode>\d) (?<orient_def>\d)( (?<rotation>\d{0,3}))?;(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/

  attr_accessor :x, :y, :symbol_index

  def initialize(match_data_hash)
    @match_data_hash = match_data_hash
    @x = match_data_hash['x']
    @y = match_data_hash['y']
    @symbol_index = match_data_hash['apt_def']
  end

  def self.from_lines(file_lines)
    parse(file_lines).map do |match_data_hash|
      new(match_data_hash)
    end
  end

  def describe
    {
      :id => @match_data_hash['id'],
      :x => @match_data_hash['x'],
      :y => @match_data_hash['y']
    }
  end
end