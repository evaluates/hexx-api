Hexx::API
=========

[![Gem Version](https://img.shields.io/gem/v/hexx-api.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/hexx-api/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/hexx-api.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nepalez/hexx-api.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/nepalez/hexx-api.svg?style=flat)][coveralls]
[![Inline docs](http://inch-ci.org/github/nepalez/hexx-api.svg)][inch]

[codeclimate]: https://codeclimate.com/github/nepalez/hexx-api
[coveralls]: https://coveralls.io/r/nepalez/hexx-api
[gem]: https://rubygems.org/gems/hexx-api
[gemnasium]: https://gemnasium.com/nepalez/hexx-api
[travis]: https://travis-ci.org/nepalez/hexx-api
[inch]: https://inch-ci.org/github/nepalez/hexx-api

The syntax sugar to wrap module content to kind of public API.

Synopsis
--------

```ruby
# lib/my_module.rb
require "hexx-api"

# Load the code of the module (including some services)
require_relative "my_module/add_foo.rb"
require_relative "my_module/add_bar.rb"
# ...

# Provides public API for the module
module MyModule
  extend Hexx::API

  api_method :add_foo, :AddFoo  # :new is the default method
  api_method :add_bar, :AddBar, :build
end
```

```ruby
MyModule[:add_foo]
# => Foo

MyModule.add_foo(*args)
# This is the same as AddFoo.new(*args)

MyModule[:add_bar]
# => Bar

MyModule.add_bar(*args)
# This is the same as AddBar.build(*args)
```

Installation
------------

Add this line to your application's Gemfile:

```ruby
# Gemfile
gem "hexx-api"
```

Then execute:

```
bundle
```

Or add it manually:

```
gem install hexx-api
```

Compatibility
-------------

Tested under rubies compatible to API 1.9.2+:

* MRI 1.9.3+
* Rubinius-2+ (modes 1.9+)
* JRuby-1.7+

Uses [RSpec] 3.0+ for testing and [hexx-suit] for dev/test tools collection.

[RSpec]: http://rspec.info/
[hexx-suit]: http://github.com/nepalez/hexx-suit

License
-------

See the [MIT LICENSE](LICENSE).
