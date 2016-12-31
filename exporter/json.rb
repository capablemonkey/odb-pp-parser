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

    JSON.dump(output)
  end

  def self.dump_netlist(file_lines)
    nets = OdbNet::parse_nets(file_lines)
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

    JSON.dump(output)
  end

  def self.dump_features_with_net(feature_lines, netlist_lines)
    pads = Pad::parse_pads(feature_lines)
    symbols = FeatureSymbolName::parse_symbols(feature_lines)

    nets = OdbNet::parse_nets(netlist_lines)
    points = NetPoint::parse_netpoints(netlist_lines)

     # associate net points with net:
    nets_by_id = nets.map { |net| [net.serial_num, net] }.to_h
    points.each do |point|
      net = nets_by_id[point.net_num]
      net.points.push(point)
    end

    # points to net
    points_to_net = points.map { |point| [point.point_key, nets_by_id[point.net_num]] }.to_h

    output = {
      :pads => pads.map do |pad|
        net = points_to_net[pad.point_key]
        pad.describe(symbols).merge({:net => (net ? net.name : nil)})
      end
    }

    JSON.dump(output)
  end
end

