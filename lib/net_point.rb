class NetPoint < Parseable
  REGEX = /^(?<net_num>\d*) (?<radius>\d*(.\d*)?) (?<x>\d*(.\d*)?) (?<y>\d*(.\d*)?) (?<side>T|D|B|I) ((?<w>\d*(.\d*)?) (?<h>\d*(.\d*)?) )?(?<epoint>e|m) (?<exp>e|c|p|s)/

  attr_accessor :net_num, :x, :y, :net

  def initialize(match_data_hash)
    @match_data_hash = match_data_hash

    @net_num = match_data_hash['net_num']
    @x = match_data_hash['x']
    @y = match_data_hash['y']
  end

  def describe
    {
      :x => @x,
      :y => @y
    }
  end

  def self.from_lines(file_lines)
    parse(file_lines).map do |match_data_hash|
      new(match_data_hash)
    end
  end
end