describe Album do
  let(:index) { Tagliani::Search::Index.new }
  let(:artist) { Artist.create(name: "ZZTop") }
  subject { described_class.create(name: "Hits of 70s'") }
  context 'when it adds new tag' do
    it '#tags return indexed array' do
      subject.tags.add(name: 'impressive')
      subject.tags.add(name: 'charming')
      expect(subject.tags.map(&:name)).to include('impressive', 'charming')
    end

    it 'tags support where search' do
      subject.tags.add(name: 'charming')
      result = subject.tags.search(where: { tag_name: ['char*'] })
      expect(result.map(&:name)).to include('charming')
    end

    it 'inherit tags from the model it belongs_to' do
      artist.tags.add(name: "El Diablo")
      index.bulk!
      index.refresh
      tejas = described_class.create(name: "Tejas", artist_id: artist.id)
      expect(tejas.tags.inherit).to be_truthy
      expect(tejas.tags.length).to eq(1)
      expect(tejas.tags).to eq(artist.tags)
    end
  end
end