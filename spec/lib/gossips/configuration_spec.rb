RSpec.describe Gossips::Configuration do
  context ".new" do
    subject { described_class.new }

    it "responds to elasticsearch, redis and schema" do
      expect(subject).to respond_to(:elasticsearch)
      expect(subject).to respond_to(:redis)
      expect(subject).to respond_to(:schema)
    end
  end
end