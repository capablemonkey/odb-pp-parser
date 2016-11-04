require_relative 'parseable.rb'

class Symbol
  def initialize(type, params)
    @type = type
    @params = params
  end

  def self.from_symbol_name(symbol_name)

  end
end

class FeatureSymbolName < Parseable
  REGEX = /^\$(?<serial_num>\d*) (?<symbol_name>[[:alnum:]]*)( (?<measurements>I|M))?$/

  def self.parse_symbols(file_lines)
    parse(file_lines).map do |match_data_hash|
      Symbol.from_symbol_name(match_data_hash['symbol_name'])
    end
  end
end