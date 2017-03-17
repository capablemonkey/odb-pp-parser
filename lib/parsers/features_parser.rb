class FeaturesParser
  attr_accessor :pads, :symbols

  def initialize(file_lines)
    @pads = Pad::from_lines(file_lines)
    @symbols = FeatureSymbolName::from_lines(file_lines)
  end

  def describe_pads
    @pads.map do |pad|
      pad.describe.
        merge(:symbol => @symbols[pad.symbol_index].to_h).
        merge(yield pad)
    end
  end
end