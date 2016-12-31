require_relative '../../exporter/json.rb'

describe JSONExporter do
  describe '#dump_features' do
    context 'with pads' do
      let(:file_lines) do
        [
          "$1 r55",
          "P 1.94 0.36 1 P 0 8 0;1=0,2=1;ID=90"
        ]
      end

      it 'should represent the round in JSON as expected' do
        expect(JSONExporter::dump_features(file_lines)).to eq('{"pads":[{"id":"90","symbol":{"type":"round","diameter":55.0},"x":1.94,"y":0.36}]}')
      end
    end
  end

  describe '#dump_netlist' do
    context 'with nets' do
      let(:file_lines) do
        [
          "$2 OUT_DATA_POS",
          "2 0.0185 1.36 0.46 B m e staggered 0 0 0 v"
        ]
      end

      it 'should represent the net in JSON as expected' do
        expect(JSONExporter::dump_netlist(file_lines)).to eq('{"nets":[{"name":"OUT_DATA_POS","points":[{"x":1.36,"y":0.46}]}]}')
      end
    end
  end
end