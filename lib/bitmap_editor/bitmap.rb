require 'pry'

class Bitmap
  def initialize(width:, height:)
    @rows = (1..width).map do
      Array.new(height, 'O')
    end
  end

  def color_pixel(x:, y:, color:)
    @rows[x - 1][y - 1] = color
    self
  end

  def draw_vertical_segment(x:, y1:, y2:, color:)
    (y1..y2).reduce(self) do |bitmap, y|
      bitmap.color_pixel(x: x, y: y, color: color)
    end
  end

  def draw_horizontal_segment(y:, x1:, x2:, color:)
    (x1..x2).reduce(self) do |bitmap, x|
      bitmap.color_pixel(x: x, y: y, color: color)
    end
  end

  def to_s
    @rows.transpose.map{ |row| row.join }.join("\n")
  end
end
