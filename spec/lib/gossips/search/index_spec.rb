RSpec.describe Gossips::Search::Index do
  context "manage indices" do
    before(:all) do
      @index_name = SecureRandom.hex
    end

    context ".move!" do
      def clean_up!
        [old_index, new_index].each do |name|
          described_class.delete!(name: name)
        end
      end

      before(:each) { clean_up! }
      after(:each) { clean_up! }

      let(:old_index) { "gossips_test_old_index" }
      let(:new_index) { "gossips_test_new_index" }

      let(:old_schema) do
        {
          settings: {
            analysis: {
              analyzer: {
                gossipAnalyzer: {
                  type: 'standard',
                  tokenizer: 'whitespace'
                }
              }
            }
          },
          mappings: {
            doc: {
              properties: {
                query: { type: 'percolator' },
                object_kls: { type: 'keyword', index: true },
                object_id: { type: 'integer' },
                object_created_at: { type: 'date', format: 'yyyy-MM-dd HH:mm:ss' },
                tag_id: { type: 'integer' },
                tag_name: { type: 'text' },
                last_updated: { type: 'date', format: 'yyyy-MM-dd HH:mm:ss' }
              }
            }
          }
        }
      end

      it "moves to the new index" do
        described_class.create!(name: old_index, schema: old_schema)
        described_class.move!(from: old_index, to: new_index)
        expect(Gossips::Search.client.cat.indices).to include(new_index)
      end
    end

    it ".create!" do
      described_class.create!(name: @index_name)
    end

    it ".delete!" do
      expect(described_class.delete!(name: @index_name)).to eq({"acknowledged" => true})
    end
  end
end