describe Retweet do
  let(:tweet) { Tweet.create(body: "@danbuci is a perfect example...") }
  subject { described_class.create(tweet_id: tweet.id) }
  context 'when it adds new tag' do
    it 'prints attached tags' do
      subject.tags.add(name: '#interviews')
      tags = subject.tags.map(&:name)
      expect(tags).to include('#interviews')
    end

    it 'prints attached tags from the parent class' do
      subject.tags.add(name: '#programming')
      tags = Tweet.find(subject.id).tags.map(&:name)
      expect(tags).to include('#programming')
    end
  end
end