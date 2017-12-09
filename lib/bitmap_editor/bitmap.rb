require 'pry'

class Bitmap
  MAXIMUM_WIDTH = 250
  MAXIMUM_HEIGHT = 250

  def initialize(width:, height:)
    raise "Width exceeds maximum of #{MAXIMUM_WIDTH}" unless width <= MAXIMUM_WIDTH
    raise "Height exceeds maximum of #{MAXIMUM_HEIGHT}" unless height <= MAXIMUM_HEIGHT

    @width = width
    @height = height

    @rows = (1..width).map do
      Array.new(height, 'O')
    end
  end

  def clear
    Bitmap.new(width: @width, height: @height)
  end

  def color_pixel(x:, y:, color:)
    ensure_bounded_x!(x)
    ensure_bounded_y!(y)

    update do
      @rows[x - 1][y - 1] = color
    end
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

  private

  def ensure_bounded_x!(x)
    raise "Invalid x: #{x}" unless 0 < x && x <= @width && x <= MAXIMUM_WIDTH
  end

  def ensure_bounded_y!(y)
    raise "Invalid y: #{y}" unless 0 < y && y <= @height && y <= MAXIMUM_HEIGHT
  end

  def update(&block)
    deep_clone.tap do |clone|
      clone.instance_eval(&block)
    end
  end

  def deep_clone
    Marshal.load(Marshal.dump(self))
  end
end
