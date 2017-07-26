# fluent-plugin-filter_linefeeder

[![Build Status](https://secure.travis-ci.org/sonots/fluent-plugin-filter_linefeeder.png?branch=master)](http://travis-ci.org/sonots/fluent-plugin-filter_linefeeder)

A Fluentd filter plugin to convert `\\n` to `\n` (line feed)

## What to do

I usually output rails application stacktrace logs with one line using my [oneline_log_formatter](https://github.com/sonots/oneline_log_formatter) so that I can easily collect logs.
This plugin recovers its `\\n` strings into `\n` (line feed)

## Requirements

Fluentd >= v0.12

## Install

Use RubyGems:

```
gem install fluent-plugin-filter_linefeeder
```

## Configuration Example

See [example.conf](example.conf)

## Parameters

* keys
  * record keys seperated by comma (,)

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2015 Naotoshi Seo. See [LICENSE](LICENSE) for details.
