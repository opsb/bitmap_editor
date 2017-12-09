require "bitmap_editor/bitmap"

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    commands = File.open(file).map(&:chomp)
    process_commands(commands, STDOUT)
  end

  def process_commands(commands, out)
    commands.each do |command|
      case command
        when /I ([1-9][0-9]*) ([1-9][0-9]*)/
          @bitmap = Bitmap.new(width: $1.to_i, height: $2.to_i)
        when 'S'
          if @bitmap
            out.puts @bitmap.to_s
          else
            out.puts "There is no image"
          end
        else
          out.puts "unrecognised command :("
      end
    end
  end
end
