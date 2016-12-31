require 'thor'
require 'require_all'
require_rel './lib'

class CLI < Thor
  desc "features <features file>", "export features file"

  def features(feature_filename)
    file_lines = File.read(feature_filename).lines
    puts JSONExporter::dump_features(file_lines)
  end

  desc "netlist <netlist file>", "export netlist file"

  def netlist(netlist_filename)
    file_lines = File.read(netlist_filename).lines
    puts JSONExporter::dump_netlist(file_lines)
  end

  desc "layer <features file> <netlist file>", "export pads with nets"

  def layer(features_filename, netlist_filename)
    feature_lines = File.read(features_filename).lines
    netlist_lines = File.read(netlist_filename).lines
    puts JSONExporter::dump_features_with_net(feature_lines, netlist_lines)
  end
end

CLI.start