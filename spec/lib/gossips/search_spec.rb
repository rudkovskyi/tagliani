RSpec.describe Gossips::Search do
  it ".client" do
    expect(described_class.client).to be_instance_of(Elasticsearch::Transport::Client)
  end
end