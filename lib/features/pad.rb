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

  def describe(symbols_hash)
    symbol_index = @match_data_hash['apt_def']
    symbol = symbols_hash[symbol_index]

    {
      :id => @match_data_hash['id'],
      :symbol => symbol.to_h,
      :x => @match_data_hash['x'],
      :y => @match_data_hash['y']
    }
  end
end