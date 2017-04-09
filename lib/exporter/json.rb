require 'json'

class JSONExporter
  def self.dump_features(file_lines)
    features = FeaturesParser.new(file_lines)

    output = {
      :pads => features.describe_pads {{}}
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
      :pads => features.describe_pads do |pad|
        net = netlist.get_net_at_point(pad.x, pad.y)
        {:net => (net ? net.name : nil)}
      end
    }

    JSON.dump(output)
  end

  def self.dump_board(feature_lines, netlist_lines, components_lines)
    board = Board.new(
      :features => feature_lines,
      :netlist => netlist_lines,
      :components => components_lines
    )

    output = board.describe_board
    JSON.dump(output)
  end
end

