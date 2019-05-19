RSpec.describe Gossips::Concerns::Search do
  let(:test_class) { Struct.new(:id) { include Gossips::Concerns::Search } }
  let(:album) { Album.create(name: "Best of 70s")}

  it "#search" do
    album.tags.add({name: 'nice'})
    search_data = test_class.search(where: { tag_name: ["ni*"] })
    expect(search_data).to eq([album])
  end
end