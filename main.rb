require 'require_all'
require_rel './exporter'

def main
  type = ARGV[0]
  filename = ARGV[1]

  return STDERR.puts 'usage: ruby main.rb (features|netlist) <file>' unless type && filename

  file_lines = File.read(filename).lines

  return puts JSONExporter::dump_features(file_lines) if type == 'features'
  return puts JSONExporter::dump_netlist(file_lines) if type == 'netlist'
end

main