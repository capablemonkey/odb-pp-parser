class FeaturesParser
  attr_accessor :pads, :symbols

  POINT_MATCH_PRECISION = 5

  def initialize(file_lines)
    @pads = Pad::from_lines(file_lines)
    @symbols = FeatureSymbolName::from_lines(file_lines)
    @lines = Line::from_lines(file_lines)
  end

  def describe_pads
    @pads.map do |pad|
      pad.describe.
        merge(:symbol => @symbols[pad.symbol_index].to_h).
        merge(yield pad)
    end
  end

  def describe_lines
    @lines.map do |line|
      line.describe.
        merge(:symbol => @symbols[line.symbol_index].to_h)
    end
  end

  def get_pad_at_point(x, y)
    @pads.
      select { |pad| approximate_match?(pad.x, x) && approximate_match?(pad.y, y) }.
      first
  end

  def approximate_match?(a, b)
    a.round(POINT_MATCH_PRECISION) == b.round(POINT_MATCH_PRECISION)
  end
end