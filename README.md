# OkLinker

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

count_urls(params)  # Get a list of shortened URLS.
                    # Allowed options:
                    # * :epp  - integer, optional. Elements per page. Default is 20.
                    # * :page - integer, optional. Page to fetch. Default is 1.
```

Also, you can call raw methods:

```ruby
get(method, params = {}, &block)

post(method, params = {}, &block)
```

For example,

    client.get('get-urls', page: 2)
    
These methods always return JSON or one of the errors listed here.

## Todo

* Write tests

## License

Licensed under the [MIT License](https://github.com/bodrovis/ok_linker/blob/master/LICENSE).

Copyright (c) 2015 [Ilya Bodrov](http://radiant-wind.com)