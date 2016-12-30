require 'json'
require 'require_all'
require_rel '../lib'

class JSONExporter
  def self.dump_features(file_lines)
    pads = Pad::parse_pads(file_lines)
    symbols = FeatureSymbolName::parse_symbols(file_lines)

    output = {
      :pads => pads.map { |pad| pad.describe(symbols) }
    }

    JSON.pretty_generate(output)
  end

  def self.dump_netlist(file_lines)
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

    JSON.pretty_generate(output)
  end
end

