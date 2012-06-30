# webhook-payload

[![Build Status](http://travis-ci.org/blatyo/webhook-payload.png)](http://travis-ci.org/blatyo/webhook-payload)

This gem is a convenience wrapper for [Github's webhook payload](https://help.github.com/articles/post-receive-hooks) that is triggered from a post receive hook. Feed it a hash of data and it will parse it into an object that you can use.

## Setup

**Gemfile**
``` ruby
gem 'webhook-payload'
```

**Manual**
``` ruby
require 'webhook/payload'
```

## Usage

Say you have a hash from a post receive hook like so:

``` ruby
payload_data = {
  "before" => "5aef35982fb2d34e9d9d4502f6ede1072793222d",
  "repository" => {
    "url" => "http://github.com/defunkt/github",
    "name" => "github",
    "description" => "You're lookin' at it.",
    "watchers" => 5,
    "forks" => 2,
    "private" => 1,
    "owner" => {
      "email" => "chris@ozmm.org",
      "name" => "defunkt"
    }
  },
  "commits" => [
    {
      "id" => "41a212ee83ca127e3c8cf465891ab7216a705f59",
      "url" => "http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59",
      "author" => {
        "email" => "chris@ozmm.org",
        "name" => "Chris Wanstrath"
      },
      "message" => "okay i give in",
      "timestamp" => "2008-02-15T14:57:17-08:00",
      "added" => ["filepath.rb"]
    },
    {
      "id" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
      "url" => "http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0",
      "author" => {
        "email" => "chris@ozmm.org",
        "name" => "Chris Wanstrath"
      },
      "message" => "update pricing a tad",
      "timestamp" => "2008-02-15T14:36:34-08:00"
    }
  ],
  "after" => "de8251ff97ee194a289832576287d6f8ad74e3d0",
  "ref" => "refs/heads/master"
}
```

You can load that into an object with:

``` ruby
payload = Webhook::Payload.new(payload_data)
```

Then you can access the data via methods rather than through hash keys. It also does conversion of timestamps to `Time`, integer booleans to `true` or `false`, urls to `URI`, and file to `Pathname`.

``` ruby
payload.after                         #=> "de8251ff97ee194a289832576287d6f8ad74e3d0"
payload.repository.url                #=> #<URI::HTTP:0x007ff14b0ace60 URL:http://github.com/defunkt/github>
payload.commits.first.author.name     #=> "Chris Wanstrath"
payload.commits.first.timestamp       #=> 2008-02-15 17:57:17 -0500
payload.commits.first.timestamp.class #=> Time
payload.commits.first.added.first     #=> #<Pathname:filepath.rb>
payload.repository.private?           #=> true
```

Hopefully, everything else you can do is pretty obvious. Method names and hash key names are all the same.

## Note on Reporting Issues

* Try to make a failing test case
* Tell me which version of ruby you're using
* Tell me which OS you are using
* Provide me with any extra files if necessary

## Note on Patches/Pull Requests
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.