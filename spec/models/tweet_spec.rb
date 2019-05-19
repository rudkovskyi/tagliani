describe Tweet do
  subject { described_class.create(body: "Follow @rrubyist on Twitter'") }
  context 'when it adds new tag' do
    it '#tags return an indexed array' do
      subject.tags.add(name: '#promotion')
      expect(subject.tags.map(&:name)).to include('#promotion')
      expect(Hashtag.last.name).to eq('#promotion')
    end

    it 'able to find a tweet by the hashtag' do
      subject.tags.add(name: '#followme')
      search_data = Hashtag.search(where: { tag_name: ['#followme'], tag_kls: ['Hashtag'] })
      expect(search_data).to eq([subject])
    end
  end
end