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
          tempfile.puts(title)
        
          arguments.each do |viewfile|
            tempfile.puts(page(viewfile))
          end
        
          tempfile.flush
          Rabbit::Command::Rabbit.run(tempfile.path)
        end
      end

      private
      def title
        <<-EOT
= RabbitViewer
: date
   version #{::RabbitViewer::VERSION}
        EOT
      end

      def page(viewfile)
        <<-EOT
= #{File.basename(viewfile)}
  # image
  # src = #{viewfile}
        EOT
      end
    end
  end
end
