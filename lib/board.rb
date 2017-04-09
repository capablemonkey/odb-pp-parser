class Board
  def initialize(files)
    @netlist = NetlistParser.new(files[:netlist])
    @features = FeaturesParser.new(files[:features])
    @components = ComponentsParser.new(files[:components]).components
  end

  def describe_components
    @components.map do |component|
      {
        :id => component['id'],
        :x => component['x'],
        :y => component['y'],
        :comp_name => component['comp_name'],
        :part_name => component['part_name'],
        :rotation => component['rot'],
        :mirror => component['mirror'],
        :properties => component['properties'],
        :toeprints => component['toeprints'].map do |toeprint|
          underlying_pad = @features.get_pad_at_point(toeprint['x'], toeprint['y'])
          {
            :x => toeprint['x'],
            :y => toeprint['y'],
            :net => @netlist.get_net_by_index(toeprint['net_num']).name,
            :pad_id  => underlying_pad ? underlying_pad.id : nil
          }
        end
      }
    end
  end

  def describe_pads
    @features.describe_pads do |pad|
      net = @netlist.get_net_at_point(pad.x, pad.y)
      {:net => (net ? net.name : nil)}
    end
  end

  def describe_board
    {
      :nets => @netlist.nets.map(&:name),
      :components => describe_components,
      :pads => describe_pads,
      :lines => @features.describe_lines
    }
  end
end