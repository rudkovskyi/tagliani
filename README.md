![alt text](https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.quotesgram.com%2Fimg%2F23%2F86%2F1732449599-Friends-Quotes-Joey-Tribbiani.jpg&f=1)

# Tagliani

Blazing fast Ruby alternative to `acts-as-taggable-on` and other similar gems. Instead of million of records in the database it uses powerful ElasticSearch, which gives a very fast and scalable solution with a search capabilities of ElasticSearch.

## Installation

All you need is to add in your `Gemfile` the follwing line.

```ruby
gem 'tagliani'
```

And run `bundle install` command.

## Search

Let's say inside the Rails application you have a model with a name "Hashtag", that represents all the tags attached to the model "Tweet".

```ruby
class Hashtag < ActiveRecord::Base
  include Tagliani::Concerns::Search
end

class Tweet < ActiveRecord::Base
  taggable tag_kls: "Hashtag"
end
```

*tag_kls is optional. By default it set to `Tag` model*

To attach the tag simply execute:

```ruby
tweet = Tweet.create(body: "Follow @rrubyist on Twitter")
tweet.tags.add(name: '#followme')
```

To list the attached tags you can run:

```ruby
tweet.tags
```

It will return you an array of `Hashtag` objects attached to the `Tweet` model.

```ruby
[#<Hashtag id: 2, name: "#followme", sticker: "default">]
```

If you want to search for all tweets attached to the `Hashtag` model with a name `#followme` you can use public `search` method defined in class.

*You don't have to specify `tag_kls`, unless you have multiple models that act as Tag model*

```ruby
Hashtag.search(where: { tag_name: ['#followme'], tag_kls: ['Hashtag'] }
```

Tag name represents the `name` field of the `Hashtag` model.

```ruby
[#<Tweet id: 3, body: "Tweet #0">, #<Tweet id: 4, body: "Tweet #1">, 
#<Tweet id: 5, body: "Tweet #2">, #<Tweet id: 6, body: "Follow @rrubyist on Twitter">]
```

## Asyncronous bulk index

For a non-blocking processes you can enable option to index jobs in background queue.

```ruby
class Artist < ActiveRecord::Base
  has_many :albums
  tagliani async: true
end
```

### Requirements

* ActiveRecord

To run this gem it is required to have ActiveRecord.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rudkovskyi/tagliani. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tagliani project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rudkovskyi/tagliani/blob/master/CODE_OF_CONDUCT.md).
