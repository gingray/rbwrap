RSpec.describe Rbwrap::Parser, focus: true do

  context 'parse case 1' do
    let(:input) { 'TestConst::NestedConst.method_1'}
    it do
      expect(Rbwrap::ParserNew.new.parse(input)).to eq []
    end
  end
end
