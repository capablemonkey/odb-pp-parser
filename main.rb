require 'require_all'
require_all './lib'

def main
  filename = ARGV.first || "sample_features"
  file_lines = File.read(filename).lines

  pads = Pad::parse_pads(file_lines)
  feature_symbol_names = FeatureSymbolName::parse(file_lines)

  output = {
    :pads => pads.map { |pad| pad.describe(feature_symbol_names) }
  }

  puts JSON.dump(output)
end

main