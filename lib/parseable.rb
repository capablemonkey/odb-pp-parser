class Parseable
  REGEX = nil

  def self.parse(file_lines)
    raise "No regex defined" if regex.nil?

    matches = file_lines.map do |line|
      match_data = regex.match(line)
      match_data_to_hash(match_data) if match_data
    end

    matches.delete_if &:nil?
  end

  private

    def self.regex
      self::REGEX
    end

    def self.match_data_to_hash(match_data)
      match_data.names.zip(match_data.captures).to_h
    end
end