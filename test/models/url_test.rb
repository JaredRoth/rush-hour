require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_urls

    assert Url.first.respond_to?(:url)
    assert_equal "http://jumpstartlab.com/blog", Url.first.url
    assert_equal "http://google.com/about", Url.second.url
    assert_equal "http://yahoo.com/about", Url.last.url
  end

  def test_nil_does_not_get_created
    create_urls

    assert_equal 3, Url.count
  end
end
