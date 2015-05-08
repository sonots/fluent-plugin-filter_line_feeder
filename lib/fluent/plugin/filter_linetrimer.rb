module Fluent
  class LinetrimerFilter < Filter
    Fluent::Plugin.register_filter('linetrimer', self)

    config_param :key, :string
    config_param :num, :integer

    def initialize
      require 'string/scrub' if RUBY_VERSION.to_f < 2.1
      super
    end

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      return record unless record[key]
      record[key] = trim(record[key], num)
      record
    end

    def trim(string, num)
      begin
        string.split("\n")[0...num].join("\n")
      rescue ArgumentError => e
        raise e unless e.message.index("invalid byte sequence in") == 0
        string.scrub!('?')
        retry
      end
    end
  end
end
