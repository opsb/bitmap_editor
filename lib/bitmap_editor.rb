require "bitmap_editor/bitmap"

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    commands = File.open(file).map(&:chomp)
    CommandProcessor.new(STDOUT).process(commands)
  end

  class CommandProcessor
    def initialize(out)
      @out = out
    end

    def process(commands)
      commands.each do |command|
        case command
          when /I ([1-9][0-9]*) ([1-9][0-9]*)/
            @bitmap = Bitmap.new(width: $1.to_i, height: $2.to_i)
          when /L ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])/
            when_bitmap do
              @bitmap.color_pixel(x: $1.to_i, y: $2.to_i, color: $3)
            end
          when 'S'
            when_bitmap do
              @out.puts @bitmap.to_s
            end
          else
            @out.puts "unrecognised command :("
        end
      end
    end

    def when_bitmap
      if @bitmap
        yield
      else
        @out.puts "There is no image"
      end
    end
  end
end
