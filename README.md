[![Build](https://github.com/robinbortlik/dock-api/actions/workflows/build.yml/badge.svg)](https://github.com/robinbortlik/dock-api/actions/workflows/build.yml)
[![Scheduled Build](https://github.com/robinbortlik/dock-api/actions/workflows/scheduled_build.yml/badge.svg)](https://github.com/robinbortlik/dock-api/actions/workflows/scheduled_build.yml)

# dock-api

Ruby client for [Dock network](https://dock.io/) API .

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dock-api'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install dock-api
```

## Configuration

In order to connect to dock API you firs need to generate API token, which can be done on https://console.api.dock.io/ .

```ruby
Dock::Api.configure do |conf|
  conf.auth_token = ENV.fetch("DOCK_API_TOKEN")
  conf.host = "https://api.dock.io"
  conf.log_requests = true # useful for debugging
  conf.request_retry_count = 3 # default 1
end

```

### Usage

```ruby
# Anchors

Dock::Api::Anchors.list
Dock::Api::Anchors.find
Dock::Api::Anchors.create
Dock::Api::Anchors.verify

# Credentials

Dock::Api::Credentials.find
Dock::Api::Credentials.destroy
Dock::Api::Credentials.create

# Dids

Dock::Api::Dids.list
Dock::Api::Dids.find
Dock::Api::Dids.create
Dock::Api::Dids.update
Dock::Api::Dids.destroy

# Jobs

Dock::Api::Jobs.find

# Presentations

Dock::Api::Presentations.create

# Profiles

Dock::Api::Profiles.list
Dock::Api::Profiles.find
Dock::Api::Profiles.create
Dock::Api::Profiles.update
Dock::Api::Profiles.destroy

# Registries

Dock::Api::Registries.list
Dock::Api::Registries.find
Dock::Api::Registries.create
Dock::Api::Registries.destroy
Dock::Api::Registries.revoke
Dock::Api::Registries.unrevoke

# RevocationStatus

Dock::Api::RevocationStatus.find

# Schemas

Dock::Api::Schemas.list
Dock::Api::Schemas.find
Dock::Api::Schemas.create

# Verify

Dock::Api::Verify.verify
```

### Documentations

Gem documentation: https://www.rubydoc.info/github/robinbortlik/dock-api/main

Official Dock API documentation: https://docs.api.dock.io/#the-dock-api

Swagger console: https://swagger.api.dock.io/


### Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/robinbortlik/dock-api.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
