class OdbSymbol
  extend Parseable

  STANDARD_SYMBOLS = {
    /^r(?<diameter>\d+(\.?\d*))$/ => :round,
    /^s(?<width>\d+\.?\d*)$/ => :square,
    /^rect(?<width>\d+\.?\d*)x(?<height>\d+\.?\d*)$/ => :rect,
    /^oval(?<width>\d+\.?\d*)x(?<height>\d+\.?\d*)$/ => :oval
  }

  def initialize(type, params)
    @type = type
    @params = params
  end

  def self.from_symbol_name(symbol_name)
    matching_regex = STANDARD_SYMBOLS.
      keys.
      map { |regex, _| regex if regex =~ symbol_name }.
      reject(&:nil?).
      first

    raise "Symbol not supported: #{symbol_name}" unless matching_regex

    type = STANDARD_SYMBOLS[matching_regex]
    params = match_data_to_hash(matching_regex.match(symbol_name))

    new(type, params)
  end

  def to_h
    {
      :type => @type
    }.merge(@params)
  end
end