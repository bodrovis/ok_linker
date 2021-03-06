# OkLinker

[![Gem Version](https://badge.fury.io/rb/ok_linker.svg)](https://badge.fury.io/rb/ok_linker)
[![Build Status](https://travis-ci.org/bodrovis/ok_linker.svg?branch=master)](https://travis-ci.org/bodrovis/ok_linker)
[![Code Climate](https://codeclimate.com/github/bodrovis/ok_linker/badges/gpa.svg)](https://codeclimate.com/github/bodrovis/ok_linker)

Ruby gem to work with Odnoklassniki's URL shortening service [okey.link](http://okey.link). Tested against Ruby 2.0, 2.1, 2.2 and 2.3.

## Installation

Via RubyGems:

    $ gem install ok_linker

Or add it to your `Gemfile`:

    gem 'ok_linker' 

## Usage

### Prerequisites

First of all, you will require access to [okey.link](https://okey.link). Fill in this [submission form](https://okey.link/cabinet/registration)
to gain access.

After logging in, copy your API access token from the [API section](https://okey.link/cabinet/api). This token
has unlimited lifetime and has to be stored securely.

### Instantiating a Client

Create a new client by typing

    client = OkLinker::Client.new(opts)
  
or simply with

    client = OkLinker.new(opts)
    
You can now call OkLinker's [methods](https://github.com/bodrovis/ok_linker#calling-methods).

### Configuration

OkLinker does not require much configuration. The only thing that you need to provide is your access token.
You can either use an initializer (for example, `ok_linker.rb`):

    OkLinker.configure do |c|
      c.access_token = 'Your token'
    end

or provide it when instantiating a new client:

    client = OkLinker::Client.new(access_token: 'Your token')

### Calling methods

You can read more about available methods [here](https://okey.link/cabinet/api).

OkLinker provides the following conventional methods:

```ruby
shorten(url)        # Shorten a given URL

hide(url)           # Hide a URL that was previously shorten

clicks(url)         # Get clicks statistics for the given URL

urls(params)        # Get a list of shortened URLs.
                    # Allowed options:
                    ## :epp  - integer, optional. Elements per page. Default is 20.
                    ## :page - integer, optional. Page to fetch. Default is 1.
```

Also, you can call raw methods:

```ruby
get(method, params = {}, &block)

post(method, params = {}, &block)
```

For example,

    client.get('get-urls', page: 2)
    
These methods always return JSON or one of the errors listed [here](https://github.com/bodrovis/ok_linker/blob/master/lib/ok_linker/error.rb#L18).

## Testing

Rename `.env.sample` to `.env` and assign `OKEY_LINK_KEY` to your API key. This file is excluded from version control, so your token won't be exposed.

Then run

    $ bundle exec rspec .

## License

Licensed under the [MIT License](https://github.com/bodrovis/ok_linker/blob/master/LICENSE).

Copyright (c) 2016 [Ilya Bodrov](http://bodrovis.tech)
