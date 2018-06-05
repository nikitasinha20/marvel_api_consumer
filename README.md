# MarvelApiConsumer

Ruby Client for Marvel API's just add gem in your project for using the Marvel API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marvel_api_consumer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marvel_api_consumer

## Usage

To use this gem, first configure it, by passing your Marvel API credentials (http://developer.marvel.com/)

    > require 'marvel_api_consumer'
    > MarvelApiConsumer.set_config({public_key: 'foo', private_key: 'bar'})
    
Once configured, you can do things like:
        
    > MarvelApiConsumer.total_characters # 1491
    > MarvelApiConsumer.paginated_character_list({limit: 50}) # optionally add page_limit - which is set to 50 by default (returns enum)
    > MarvelApiConsumer.character_list # gets the list of characters (returns enum)
    > MarvelApiConsumer.character_details(1011334) # get detailed info of a character using characterId
    
    
Following filters can be used to fetch data:
    
    1. name - Return only characters matching the specified full character name (e.g. Spider-Man).
    2. nameStartsWith - Return characters with names that begin with the specified string (e.g. Sp).
    3. comics - Return only characters which appear in the specified comics (accepts a comma-separated list of ids).
    4. series - Return only characters which appear the specified series (accepts a comma-separated list of ids).
    
Examples:
    
    > MarvelApiConsumer.character_list({name: "Spider-Man"}) # returns enum
    > MarvelApiConsumer.character_list({nameStartsWith: "sh"}) # returns enum
    > MarvelApiConsumer.character_list({comics: 21366}) # returns enum
    > MarvelApiConsumer.character_list({series: 1945}) # returns enum
         
An easy way to play with the gem without having to install it is to use the console. You need to have internet access as it will connect to the production Marvel API.
    
    $ ./bin/console
    > MarvelApiConsumer.set_config({public_key: 'foo', private_key: 'bar'})
    > MarvelApiConsumer.total_characters # 1491
    
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nikitasinha20/marvel_api_consumer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MarvelApiConsumer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/marvel_api_consumer/blob/master/CODE_OF_CONDUCT.md).
