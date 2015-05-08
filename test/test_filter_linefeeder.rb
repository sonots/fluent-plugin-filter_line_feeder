require_relative 'helper'
require 'fluent/plugin/filter_linefeeder'

class LinefeederFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
    @time = Fluent::Engine.now
  end

  def create_driver(conf = '')
    Test::FilterTestDriver.new(LinefeederFilter).configure(conf, true)
  end

  def filter(d, msg)
    d.run { d.filter(msg, @time) }
    d.filtered_as_array.first[2]
  end

  sub_test_case 'configure' do
    def test_keys
      assert_raise Fluent::ConfigError do
        create_driver('')
      end

      d = create_driver(%[keys a,b])
      assert_equal ["a","b"],  d.instance.keys
    end
  end

  sub_test_case 'filter' do
    def test_linefeed
      d = create_driver(%[keys message])
      msg = { 'message' => "foo\\nbar" }
      filtered = filter(d, msg)
      assert_equal "foo\nbar", filtered['message']
    end

    def test_scrub
      d = create_driver(%[keys message])
      msg = { 'message' => "\xff".force_encoding('UTF-8') }
      filtered = filter(d, msg)
      assert_equal "?", filtered['message']
    end
  end
end
