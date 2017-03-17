class OdbNet < Parseable
  REGEX = /^\$(?<serial_num>\d*) (?<net_name>.*)$/

  attr_accessor :name, :serial_num, :points

  def initialize(match_data_hash)
    @name = match_data_hash['net_name']
    @serial_num = match_data_hash['serial_num']
    @points = []
  end

  def describe
    {
      :name => @name,
      :points => @points.map { |point| point.describe }
    }
  end

  def self.from_lines(file_lines)
    parse(file_lines).map do |match_data_hash|
      new(match_data_hash)
    end
  end

  def add_point(netpoint)
    @points.push(netpoint)
    netpoint.net = self
  end
end