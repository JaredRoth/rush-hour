require_relative '../test_helper'

class HelperMethodsTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers
  include RushHour

  def app
    RushHour::Server
  end

  def test_link_to_assembles_link
    identifier = "jumpstartlab"
    relativepath = 'blog'
    url = "http://jumpstartlab.com/blog"
    final_string = "/sources/jumpstartlab/urls/blog"

    assert_equal final_string, link_to(identifier, relativepath, url)
  end

end
