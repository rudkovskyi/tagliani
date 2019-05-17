describe Album do
  subject { described_class.create(name: "Hits of 70s'") }
  context 'when it adds new tag' do
    it '#tags returns array of tags' do
      subject.tags.add(name: 'impressive')
      subject.tags.add(name: 'charming')
      expect(subject.tags.map(&:name)).to include('impressive', 'charming')
    end
  end
end