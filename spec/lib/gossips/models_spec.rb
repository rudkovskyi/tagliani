RSpec.describe Gossips::Models do
  context ".tagged" do
    it "should list of tagged models" do
      expect(described_class.tagged).to be_instance_of(Array)
    end
  end
end