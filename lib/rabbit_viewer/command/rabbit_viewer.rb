require "rabbit_viewer/version"
require "rabbit/command/rabbit"
require "tempfile"
require "uri"

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
            next unless File.file?(viewfile)

            begin
              URI.parse(viewfile)
            rescue URI::InvalidURIError
              STDERR.puts($!.message)
              STDERR.puts("Sorry, don't support multibyte file name as yet.")
              next
            end

            case viewfile
            when /\.(svg|png|jpe?g|gif|eps)$/
              tempfile.puts(image_page(viewfile))
            else
              tempfile.puts(text_page(viewfile))
            end
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

      def image_page(viewfile)
        <<-EOT
= #{File.basename(viewfile)}
  # image
  # src = #{viewfile}
        EOT
      end

      def text_page(viewfile)
        page = "= #{File.basename(viewfile)}\n"
        File.open(viewfile) do |f|
          f.each_line.to_a[0..9].each_with_index do |line, i|
            page += "    #{i + 1}: #{line}\n"
          end
        end
        page
      end
    end
  end
end
