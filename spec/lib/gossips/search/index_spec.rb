RSpec.describe Gossips::Search::Index do
  context "manage indices" do
    before(:all) do
      @index_name = SecureRandom.hex
    end

    it ".create_index!" do
      described_class.create_index!(name: @index_name)
    end

    it ".delete_index!" do
      expect(described_class.delete_index!(name: @index_name)).to eq({"acknowledged" => true})
    end
  end
end