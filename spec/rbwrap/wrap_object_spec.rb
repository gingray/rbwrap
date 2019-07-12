RSpec.describe Rbwrap::WrapObject, focus: true do

  context 'parse case 1' do
    let(:input) { 'TestConst::NestedConst.method_1'}
    let(:result) { Rbwrap::WrapObject.build(input) }
    it do
      expect(result.method_name).to eq 'method_1'
      expect(result.method_type).to eq Rbwrap::WrapObject::INSTANCE_METHOD
      expect(result.namespace).to eq '::TestConst::NestedConst'
    end
  end
end
