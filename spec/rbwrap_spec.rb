RSpec.describe Rbwrap, focus: true do
  it "has a version number" do
    binding.pry
    expect(Rbwrap::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
