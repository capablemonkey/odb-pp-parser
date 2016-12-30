require 'require_all'
require_all './lib'
require 'json'

def parse_netlist
  filename = ARGV.first || "sample/netlist"
  file_lines = File.read(filename).lines

  nets = Net::parse_nets(file_lines)
  points = NetPoint::parse_netpoints(file_lines)

  # associate net points with net:
  nets_by_id = nets.map { |net| [net.serial_num, net] }.to_h
  points.each do |point|
    net = nets_by_id[point.net_num]
    net.points.push(point)
  end

  output = {
    :nets => nets.map { |net| net.describe }
  }

  puts JSON.pretty_generate(output)
end

parse_netlist