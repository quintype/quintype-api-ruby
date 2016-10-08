# Quintype::Api

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/quintype/api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quintype-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quintype-api

## Usage

### Establishing Connection

First, you must establish a connection, as follows

```ruby
Quintype::API::Client.establish_connection("http://sketches.quintype.com", Faraday.default_adapter)
```

### Subclassing API classes

It is highly recommended that you subclass API sections. This is mostly honored during requests. If you use liquid, implement a to_liquid method.

```ruby
class QtConfig < Quintype::API::Config
  def to_liquid
    ActiveSupport::HashWithIndifferentAccess.new to_h
  end
end

class Story < Quintype::API::Story
  def to_liquid
    ActiveSupport::HashWithIndifferentAccess.new to_h
  end
end

class Author < Quintype::API::Author
  def to_liquid
    ActiveSupport::HashWithIndifferentAccess.new to_h
  end
end
```

### Fetching the Config

```ruby
QtConfig.get.sections
```

### Fetching a story by slug

```ruby
Story.find_by_slug("5-timeless-truths-from-the-serenity-prayer-that-offer-wisdom")
```

### Fetching an group of story
```ruby
stories = Story.fetch('top', section: "Politics")
```

### Searching for stories

```ruby
stories = Story.search(q: "Peter")
stories.map {|i| i.headline }
p stories.total
```

### Bulk Fetching stories

```ruby
request = Quintype::API::Bulk.new
request
  .add_request("entertainment", Story.bulk_stories_request("top").add_params(section: "Entertainment"))
  .add_request("sports", Story.bulk_stories_request("top").add_params(section: "Sports"))
  .execute!
entertainment_stories = request.get_response("entertainment")
sports_stories = request.get_response("sports")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quintype/quintype-api-ruby.
