require "rabbit_viewer/version"
require "rabbit/command/rabbit"
require "tempfile"

module RabbitViewer
  module Command
    class RabbitViewer

      class << self
        def run(*arguments)
          new.run(arguments)
        end
      end

      def initialize
      end

      def run(arguments)
        Tempfile.open(["rabbit_viewer", ".rab"]) do |tempfile|
            title = <<-EOT
= RabbitViewer
: date
   version #{::RabbitViewer::VERSION}
            EOT
            tempfile.puts(title)
        
            arguments.each do |viewfile|
              page = <<-EOT
= #{File.basename(viewfile)}
  # image
  # src = #{viewfile}
              EOT
              tempfile.puts(page)
            end
        
          tempfile.flush
          Rabbit::Command::Rabbit.run(tempfile.path)
        end
      end
    end
  end
end
