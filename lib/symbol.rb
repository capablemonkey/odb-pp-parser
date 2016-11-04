require_relative 'parseable.rb'

class OdbSymbol < Parseable
  STANDARD_SYMBOLS = {
    /r(?<diameter>\d*)/ => :round,
    /s(?<side>\d*)/ => :square,
    /rect(?<width>\d*)x(?<height>\d*)/ => :rect,
    /oval(?<width>\d*)x(?<height>\d*)/ => :oval
  }

  def initialize(type, params)
    @type = type
    @params = params
  end

  def self.from_symbol_name(symbol_name)
    puts symbol_name

    matching_regex = STANDARD_SYMBOLS.
      keys.
      map { |regex, _| regex if regex =~ symbol_name }.
      reject(&:nil?).
      first

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

class FeatureSymbolName < Parseable
  REGEX = /^\$(?<serial_num>\d*) (?<symbol_name>[[:alnum:]]*)( (?<measurements>I|M))?$/

  def self.parse_symbols(file_lines)
    parse(file_lines).map do |match_data_hash|
      OdbSymbol::from_symbol_name(match_data_hash['symbol_name'])
    end
  end
end