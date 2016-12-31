require 'json'
require 'require_all'
require_rel '../lib'

class JSONExporter
  def self.dump_features(file_lines)
    features = FeaturesParser.new(file_lines)

    output = {
      :pads => features.describe_pads
    }

    JSON.dump(output)
  end

  def self.dump_netlist(file_lines)
    netlist = NetlistParser.new(file_lines)

    output = {
      :nets => netlist.describe_nets
    }

    JSON.dump(output)
  end

  def self.dump_features_with_net(feature_lines, netlist_lines)
    features = FeaturesParser.new(feature_lines)
    netlist = NetlistParser.new(netlist_lines)

    output = {
      :pads => features.pads.map do |pad|
        net = netlist.get_net_at_point(pad.x, pad.y)
        pad.describe(features.symbols).merge({:net => (net ? net.name : nil)})
      end
    }

    JSON.dump(output)
  end
end

