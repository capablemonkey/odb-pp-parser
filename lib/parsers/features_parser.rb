class FeaturesParser
  attr_accessor :pads, :symbols

  def initialize(file_lines)
    @pads = Pad::parse_pads(file_lines)
    @symbols = FeatureSymbolName::parse_symbols(file_lines)
  end

  def describe_pads
    @pads.map { |pad| pad.describe(@symbols) }
  end
end