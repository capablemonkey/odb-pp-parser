require 'require_all'
require_all './lib'
require 'json'

def parse_features
  filename = ARGV.first || "sample/features"
  file_lines = File.read(filename).lines

  pads = Pad::parse_pads(file_lines)
  symbols = FeatureSymbolName::parse_symbols(file_lines)

  output = {
    :pads => pads.map { |pad| pad.describe(symbols) }
  }

  puts JSON.pretty_generate(output)
end

parse_features