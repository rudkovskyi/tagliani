RSpec.describe Gossips::Search::Index::Object do
  let(:model_class) { 'TestModel' }
  let(:model_id) { rand(999) }
  let(:tag_id) { rand(999) }
  let(:object) do
    {
      model: model_class,
      id: model_id,
      created_at: Time.now.to_s,
      tag_id: tag_id,
      tag_type: 'default',
      tag_name: 'test',
      last_updated: Time.now.to_s
    }
  end

  subject { described_class.new(object.to_json) }
  context "#id" do
    it "returns unique identifier based on model name and tag id" do
      expect(subject.id).to eq("#{model_class.downcase}_#{model_id}_#{tag_id}")
    end
  end
  context "#to_h" do
    it "returns hash object" do
      expect(subject.to_h).to be_instance_of(Hash)
    end
  end
end