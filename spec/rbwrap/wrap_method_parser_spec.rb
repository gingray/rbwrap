RSpec.describe Rbwrap::WrapMethodParser do

  context 'parse case 1' do
    let(:input) { 'TestConst::NestedConst.method_1'}
    let(:service) { Rbwrap::WrapMethodParser.new }
    before { service.parse(input) }
    it do
      expect(service.tokens).to be_a Array
    end
  end

  context 'parse case 2' do
    let(:input) { 'TestConst:::NestedConst.method_1'}
    let(:service) { Rbwrap::WrapMethodParser.new }

    it do
      expect { service.parse(input) }.to raise_error Rbwrap::ParserError
    end
  end

  context 'parse case 3' do
    let(:input) { 'TestConst::NestedConst#method_1'}
    let(:service) { Rbwrap::WrapMethodParser.new }
    before { service.parse(input) }
    it do
      expect(service.tokens).to be_a Array
    end
  end

  context 'parse case 4' do
    let(:input) { '::TestConst::NestedConst::Deep#method_1'}
    let(:service) { Rbwrap::WrapMethodParser.new }
    before { service.parse(input) }
    it do
      expect(service.tokens).to be_a Array
    end
  end


  context 'parse case 5' do
    let(:input) { '::TestConst::NestedConst::Deepxmethod_1'}
    let(:service) { Rbwrap::WrapMethodParser.new }
    before { service.parse(input) }
    it do
      expect(service.tokens).to be_a Array
    end
  end
end
