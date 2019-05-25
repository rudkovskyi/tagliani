describe Album do
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
  end
end