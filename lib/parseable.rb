module Parseable
  module_function

  REGEX = nil
  NUMBER_FIELDS = ['width', 'height', 'x', 'y', 'diameter']

  def parse(file_lines)
    raise "No regex defined" if self::REGEX.nil?

    matches = file_lines.map { |line| parse_line(line, self::REGEX) }
    matches.reject &:nil?
  end

  def parse_line(line, regex)
    match_data = regex.match(line)
    match_data_to_hash(match_data) if match_data
  end

  def match_data_to_hash(match_data)
    hash = create_hash(match_data.names, match_data.captures)
    parse_number_fields(hash)
  end

  def parse_number_fields(match_hash)
    match_hash.map do |key, value|
      [key, NUMBER_FIELDS.include?(key) ? Float(value) : value]
    end.to_h
  end

  def create_hash(keys, values)
    keys.zip(values).to_h
  end
end