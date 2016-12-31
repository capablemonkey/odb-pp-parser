require_relative '../../exporter/json.rb'

describe JSONExporter do
  describe '#dump_features' do
    context 'with pads' do
      let(:file_lines) do
        [
          "$1 r55",
          "$5 oval24x74 I",
          "P 1.94 0.36 1 P 0 8 0;1=0,2=1;ID=90",
          "P 1.21972343 0.6559187 5 P 0 8 90;0,1=1,2=0;ID=386"
        ]
      end

      it 'should represent the round in JSON as expected' do
        expect(JSONExporter::dump_features(file_lines)).to eq('{"pads":[{"id":"90","symbol":{"type":"round","diameter":55.0},"x":1.94,"y":0.36},{"id":"386","symbol":{"type":"oval","width":24.0,"height":74.0},"x":1.21972343,"y":0.6559187}]}')
      end
    end
  end

  describe '#dump_netlist' do
    context 'with nets' do
      let(:file_lines) do
        [
          "$0 $NONE$",
          "$2 OUT_DATA_POS",
          "0 0.012 1.4397234 0.3559187 T e e staggered 0 0 0",
          "2 0.0185 1.36 0.46 B m e staggered 0 0 0 v",
          "2 0.0185 0.2552531 0.4975584 B e e staggered 0 0 0"
        ]
      end

      it 'should represent the net in JSON as expected' do
        expect(JSONExporter::dump_netlist(file_lines)).to eq('{"nets":[{"name":"$NONE$","points":[{"x":1.4397234,"y":0.3559187}]},{"name":"OUT_DATA_POS","points":[{"x":1.36,"y":0.46},{"x":0.2552531,"y":0.4975584}]}]}')
      end
    end
  end

  describe "#dump_features_with_net" do
    context 'with a netlist and features' do
      let(:feature_lines) do
        [
          "$1 r55",
          "$5 oval24x74 I",
          "P 1.4397234 0.3559187 1 P 0 8 0;1=0,2=1;ID=90",
          "P 1.36 0.46 1 P 0 8 0;1=0,2=1;ID=92",
          "P 0.2552531 0.4975584 5 P 0 8 90;0,1=1,2=0;ID=386"
        ]
      end

      let(:netlist_lines) do
        [
          "$0 $NONE$",
          "$2 OUT_DATA_POS",
          "0 0.012 1.4397234 0.3559187 T e e staggered 0 0 0",
          "2 0.0185 1.36 0.46 B m e staggered 0 0 0 v",
          "2 0.0185 0.2552531 0.4975584 B e e staggered 0 0 0"
        ]
      end

      it 'should return pads with their nets' do
        expect(JSONExporter::dump_features_with_net(feature_lines, netlist_lines)).to eq('{"pads":[{"id":"90","symbol":{"type":"round","diameter":55.0},"x":1.4397234,"y":0.3559187,"net":"$NONE$"},{"id":"92","symbol":{"type":"round","diameter":55.0},"x":1.36,"y":0.46,"net":"OUT_DATA_POS"},{"id":"386","symbol":{"type":"oval","width":24.0,"height":74.0},"x":0.2552531,"y":0.4975584,"net":"OUT_DATA_POS"}]}')
      end
    end
  end
end