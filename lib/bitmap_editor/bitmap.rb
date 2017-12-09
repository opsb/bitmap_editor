require 'pry'

class Bitmap
  def initialize(width:, height:)
    @rows = (1..height).map do
      Array.new(width, 'O')
    end
  end

  def color_pixel(x:, y:, color:)
    @rows[y - 1][x - 1] = color
    self
  end

  def to_s
    @rows.map{ |row| row.join }.join("\n")
  end
end
