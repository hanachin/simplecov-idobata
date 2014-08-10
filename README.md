# SimpleCov::Formatter::IdobataFormatter

[![Build Status](https://travis-ci.org/hanachin/simplecov-idobata.svg)](https://travis-ci.org/hanachin/simplecov-idobata)
[![Code Climate](https://codeclimate.com/github/hanachin/simplecov-idobata/badges/gpa.svg)](https://codeclimate.com/github/hanachin/simplecov-idobata)
[![Test Coverage](https://codeclimate.com/github/hanachin/simplecov-idobata/badges/coverage.svg)](https://codeclimate.com/github/hanachin/simplecov-idobata)
[![Dependency Status](https://gemnasium.com/hanachin/simplecov-idobata.svg)](https://gemnasium.com/hanachin/simplecov-idobata)

report your test coverage to idobata.io.

## Installation

Add this line to your application's Gemfile:

    gem 'simplecov-idobata', require: false

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplecov-idobata

## Usage

``` ruby
require 'simplecov/idobata'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::IdobataFormatter,
]
# Set environment variable SIMPLECOV_IDOBATA_HOOK_URL or
SimpleCov::Formatter::IdobataFormatter.hook_url = "Your idobata generic webhook endpoint url"

# You can customize the coverage thresholds, default is here:
SimpleCov::Formatter::IdobataFormatter.goal = 90
SimpleCov::Formatter::IdobataFormatter.warning = 80
```

## Contributing

1. Fork it ( https://github.com/hanachin/simplecov-idobata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
