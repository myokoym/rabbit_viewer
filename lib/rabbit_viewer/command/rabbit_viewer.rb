require "rabbit/command/rabbit"
require "fileutils"

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
        tempfile= "/tmp/rabbit-viewer.#{$$}.tmp.rab"
        
        begin
          File.open(tempfile, "a") do |tempfile|
            title = "= rabbit-viewer"
            tempfile.puts(title)
        
            arguments.each do |viewfile|
              page = <<-EOT
= #{File.basename(viewfile)}
  # image
  # src = #{viewfile}
              EOT
              tempfile.puts(page)
            end
          end
        
          Rabbit::Command::Rabbit.run(tempfile)
        ensure
          FileUtils.rm(tempfile)
        end
      end
    end
  end
end
