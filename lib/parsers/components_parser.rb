class ComponentsParser
  COMPONENT_REGEX = /^(?<record_type>CMP) (?<pkg_ref>\d+) (?<x>\d*(.\d*)?) (?<y>\d*(.\d*)?) (?<rot>\d*(.\d*)?) (?<mirror>N|M) (?<comp_name>.*?) (?<part_name>.*?);(?<atrs>(?<atrval>\d*=.*)*|,|(?<atr>\d*))*;ID=(?<id>\d*)$/
  PROPERTY_REGEX = /^(?<record_type>PRP) (?<name>.*?) '(?<value>.*?)'/
  TOEPRINT_REGEX = /^(?<record_type>TOP) (?<pin_num>\d*) (?<x>\d*(.\d*)?) (?<y>\d*(.\d*)?) (?<rot>\d*(.\d*)?) (?<mirror>N|M) (?<net_num>\d*) (?<subnet_num>\d*) (?<toeprint_name>.*)/

  attr_reader :components

  def initialize(file_lines)
    # algorithm:
    # - go line by line, keeping track of the last known # CMP
    # - if line is a PRP record, add it to the current CMP
    # - if line is TOP record, add it to the current CMP
    # - if new CMP is encountered, set it as the current CMP.

    # TODO: TOEPRINT net_num tells you which net it's on.  Does that mean we can just draw components on the board and then use this ID to determine its net?
    # TODO: create a Component class which we can add properties and toeprints to?
    @components = []
    @last_component = nil   # hash describing a Component

    file_lines.each do |line|
      match = attempt_match(line)

      next if match.nil?

      if match['record_type'] == 'CMP'
        @components.push(@last_component) unless @last_component.nil?
        @last_component = match
      elsif match['record_type'] == 'PRP'
        @last_component['properties'] ||= {}
        name = match['name']
        value = match['value']
        @last_component['properties'][name] = value
      elsif match['record_type'] == 'TOP'
        @last_component['toeprints'] ||= []
        @last_component['toeprints'].push(match)
      end
    end

    @components.push(@last_component)
  end

  private

    def attempt_match(line)
      match = Parseable.parse_line(line, COMPONENT_REGEX)
      return match unless match.nil?

      match = Parseable.parse_line(line, PROPERTY_REGEX)
      return match unless match.nil?

      match = Parseable.parse_line(line, TOEPRINT_REGEX)
      return match unless match.nil?
    end
end