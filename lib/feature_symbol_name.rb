class FeatureSymbolName
  extend Parseable

  REGEX = /^\$(?<serial_num>\d*) (?<symbol_name>[[:alnum:]]*)( (?<measurements>I|M))?$/

  def self.from_lines(file_lines)
    parse(file_lines).map do |match_data_hash|
      [
        match_data_hash['serial_num'],
        OdbSymbol::from_symbol_name(match_data_hash['symbol_name'])
      ]
    end.to_h
  end
end