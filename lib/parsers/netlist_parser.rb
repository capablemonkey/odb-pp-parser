class NetlistParser
  attr_accessor :nets, :netpoints

  # decimal places to match:
  POINT_MATCH_PRECISION = 5

  def initialize(file_lines)
    @nets = OdbNet::parse_nets(file_lines)
    @netpoints = NetPoint::parse_netpoints(file_lines)

    # associate net points with net:
    nets_by_id = @nets.map { |net| [net.serial_num, net] }.to_h
    @netpoints.each do |point|
      net = nets_by_id[point.net_num]
      net.add_point(point)
    end
  end

  def describe_nets
    @nets.map { |net| net.describe }
  end

  def get_net_at_point(x, y)
    @points_to_net ||= @netpoints.map { |point| [point_key(point.x, point.y), point.net] }.to_h
    @points_to_net[point_key(x, y)]
  end

  private

    def point_key(x, y)
      "#{x.round(POINT_MATCH_PRECISION)},#{y.round(POINT_MATCH_PRECISION)}"
    end
end