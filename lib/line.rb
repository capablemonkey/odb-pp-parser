class Line
  extend Parseable

  REGEX = /^L (?<xs>\d*(.\d*)?) (?<ys>\d*(.\d*)?) (?<xe>\d*(.\d*)?) (?<ye>\d*(.\d*)?) (?<sym_num>\d*) (?<polarity>P|N) (?<dcode>\d);(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/

  attr_accessor :id, :start, :end, :symbol_index

  def initialize(match_data_hash)
    @match_data_hash = match_data_hash
    @id = @match_data_hash['id']
    @start = {
      :x => @match_data_hash['xs'],
      :y => @match_data_hash['ys']
    }

    @end = {
      :x => @match_data_hash['xe'],
      :y => @match_data_hash['ye']
    }

    @symbol_index = @match_data_hash['sym_num']
  end

  def describe
    {
      :id => @match_data_hash['id'],
      :start => @start,
      :end => @end
    }
  end

  def self.from_lines(file_lines)
    parse(file_lines).map do |match_data_hash|
      new(match_data_hash)
    end
  end
end