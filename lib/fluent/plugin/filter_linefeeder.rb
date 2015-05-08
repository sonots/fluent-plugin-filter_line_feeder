module Fluent
  class LinefeederFilter < Filter
    Fluent::Plugin.register_filter('linefeeder', self)

    config_param :keys do |val|
      val.split(',')
    end

    def initialize
      require 'string/scrub' if RUBY_VERSION.to_f < 2.1
      super
    end

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      keys.each do |key|
        linefeed!(record[key]) if record[key]
      end
      record
    end

    def linefeed!(string)
      begin
        string.gsub!("\\n", "\n")
      rescue ArgumentError => e
        raise e unless e.message.index("invalid byte sequence in") == 0
        string.scrub!('?')
        retry
      end
    end
  end
end
