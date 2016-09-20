# Envestnet::Yodlee

## Setup

In sandbox mode, point the ```base_url``` to https://rest.developer.yodlee.com/services/rest/srest/restserver/v1.0/.

Export the following environment variables:

<table>
  <tr>
    <td><strong>Environment Variables</strong></td>
  </tr>
  <tr>
    <td>YODLEE_COBRAND_LOGIN</td>
  <tr/>
  <tr>
    <td>YODLEE_COBRAND_PASSWORD</td>
  <tr/>
</table>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envestnet-yodlee'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install envestnet-yodlee

## Usage

## Testing

To run tests: ```bundle exec rake test```.

All tests are written in Minitest and HTTP requests are recorded using VCR.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pennymac/envestnet-yodlee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

