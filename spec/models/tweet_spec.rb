describe Tweet do
  subject { described_class.create(body: "Follow @rrubyist on Twitter") }
  context 'when it adds new tag' do
    def create_tweets(num)
      num.times do |n| 
        t = described_class.create(body: "Tweet ##{n}")
        yield(t)
      end
    end

    it '#tags return an indexed array' do
      subject.tags.add(name: '#followme')
      expect(subject.tags.map(&:name)).to include('#followme')
      expect(Hashtag.last.name).to eq('#followme')
    end

    it 'able to find a tweet by the partial of a hashtag' do
      subject.tags.add(name: '#developer')
      subject_tweet = Hashtag.search(where: { tag_name: ['#dev*'], tag_kls: ['Hashtag'] })
      expect(subject_tweet).to eq([subject])
    end

    it 'can find all the tweets by the hashtag' do
      create_tweets(3) {|t| t.tags.add(name: '#followme') }
      subject.tags.add(name: '#followme')
      tweets = Hashtag.search(where: { tag_name: ['#followme'], tag_kls: ['Hashtag'] })
      expect(tweets.length).to eq(4)
    end
  end
end