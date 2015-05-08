require_relative 'helper'
require 'fluent/plugin/filter_linetrimer'

class LinetrimerFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
    @time = Fluent::Engine.now
  end

  def create_driver(conf = '')
    Test::FilterTestDriver.new(LinetrimerFilter).configure(conf, true)
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

      d = create_driver(%[key a\nnum 10])
      assert_equal "a", d.instance.key
      assert_equal 10,  d.instance.num
    end
  end

  sub_test_case 'filter' do
    def test_trim
      d = create_driver(%[key message\nnum 2])
      msg = { 'message' => "foo\nbar\nbaz" }
      filtered = filter(d, msg)
      assert_equal "foo\nbar", filtered['message']
    end

    def test_scrub
      d = create_driver(%[key message\nnum 2])
      msg = { 'message' => "\xff".force_encoding('UTF-8') }
      filtered = filter(d, msg)
      assert_equal "?", filtered['message']
    end
  end
end
