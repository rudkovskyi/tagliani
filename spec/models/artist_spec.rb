describe Artist do
  let(:index) { Tagliani::Search::Index.new }
  subject { described_class.create(name: "Bon Jovi'") }
  context 'when it adds new tag' do
    it 'adds them asynchronously' do
      subject.tags.add(name: 'impressive')
      subject.tags.add(name: 'charming')
      expect(index.bulk!).to be_instance_of(Hash)
      expect(index.refresh).to be_instance_of(Hash)
      expect(subject.tags.map(&:name)).to include('impressive', 'charming')
    end
  end
end