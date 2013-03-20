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
end
