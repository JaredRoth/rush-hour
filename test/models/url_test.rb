require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    url = create_urls
    assert url.respond_to?(:url)
    assert_equal "http://jumpstartlab.com/blog", url.url
  end
end
