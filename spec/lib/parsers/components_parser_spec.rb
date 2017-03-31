require 'require_all'
require_rel '../../../lib'

describe ComponentsParser do
  describe "#components" do
    let(:file_lines) { File.read('sample/components').lines }

    it 'should parse components as expected' do
      parser = ComponentsParser.new(file_lines)
      components = parser.components

      expect(components.size).to eq(4)
      # puts components
    end
  end
end