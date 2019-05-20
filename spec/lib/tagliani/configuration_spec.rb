RSpec.describe Tagliani::Configuration do
  context ".new" do
    subject { described_class.new }

    it "responds to elasticsearch, redis, schema and tag" do
      expect(subject).to respond_to(:elasticsearch)
      expect(subject).to respond_to(:redis)
      expect(subject).to respond_to(:schema)
      expect(subject).to respond_to(:tag)
    end
  end
end