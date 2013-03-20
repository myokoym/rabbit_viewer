require "rabbit_viewer/command/rabbit_viewer"
require "rabbit_viewer/version"

class TestRabbitViewer < Test::Unit::TestCase
  def setup
    @rabbit_viewer = RabbitViewer::Command::RabbitViewer.new
  end

  def test_title
    assert_equal(<<-EOT, @rabbit_viewer.__send__(:title))
= RabbitViewer
: date
   version #{::RabbitViewer::VERSION}
    EOT
  end

  def test_image_page
    assert_equal(<<-EOP, @rabbit_viewer.__send__(:image_page, __FILE__))
= #{File.basename(__FILE__)}
  # image
  # src = #{File.expand_path(__FILE__)}
    EOP
  end

  def test_undefind_page
    assert_equal(<<-EOP, @rabbit_viewer.__send__(:undefind_page, __FILE__))
= #{File.basename(__FILE__)}
Sorry, this file is don't support format...
    EOP
  end
end
