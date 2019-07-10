RSpec.describe Rbwrap::Parser do
  let(:service) { Rbwrap::Parser.new input }

  context 'parse case 1' do
    let(:input) { 'TestConst::NestedConst.method_1'}
    before { service.call }
    it do
      expect(service.method_name).to eq 'method_1'
      expect(service.const_name).to eq 'TestConst::NestedConst'
      expect(service.method_type).to eq Rbwrap::Parser::INSTANCE_METHOD
      expect(service.const_type).to eq Rbwrap::Parser::IS_CLASS
    end
  end

  context 'parse case 2', focus: true do
    let(:input) { '   Test.call    '}
    before { service.call }
    it do
      expect(service.method_name).to eq 'call'
      expect(service.const_name).to eq 'Test'
      expect(service.method_type).to eq Rbwrap::Parser::INSTANCE_METHOD
      expect(service.const_type).to eq Rbwrap::Parser::IS_CLASS
    end
  end
end
