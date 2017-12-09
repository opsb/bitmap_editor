require "bitmap_editor/bitmap"

class BitmapEditor

  def run(file, out = STDOUT)
    raise "please provide correct file" if file.nil? || !File.exists?(file)

    commands = File.open(file).map(&:chomp)
    CommandProcessor.new(out).process(commands)
  rescue => e
    out.puts e.message
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

          when /C/
            when_bitmap do
              @bitmap = @bitmap.clear
            end

          when /I/
            fail_with_usage!(command, "I M N - Create a new M x N image with all pixels coloured white (O)")

          when /L ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])/
            when_bitmap do
              @bitmap = @bitmap.color_pixel(x: $1.to_i, y: $2.to_i, color: $3)
            end

          when /L/
            fail_with_usage!(command, "L X Y C - Colours the pixel (X,Y) with colour C")

          when /V ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])/
            when_bitmap do
              @bitmap = @bitmap.draw_vertical_segment(x: $1.to_i, y1: $2.to_i, y2: $3.to_i, color: $4)
            end

          when /V/
            fail_with_usage!(command, "V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)")

          when /H ([1-9][0-9]*) ([1-9][0-9]*) ([1-9][0-9]*) ([A-Z])/
            when_bitmap do
              @bitmap = @bitmap.draw_horizontal_segment(x1: $1.to_i, x2: $2.to_i, y: $3.to_i, color: $4)
            end

          when /H/
            fail_with_usage!(command, "H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).")

          when 'S'
            when_bitmap do
              @out.puts @bitmap.to_s
            end

          else
            raise "unrecognised command :("
        end
      end
    end

    def when_bitmap
      if @bitmap
        yield
      else
        raise "There is no image"
      end
    end


    def fail_with_usage!(command, usage)
      puts
      puts "----! The following command was invalid: #{command}"
      puts
      puts "----> Usage: #{usage}"
      puts
      raise "----! Check that the syntax you've used matches the usage shown above"
    end
  end
end
