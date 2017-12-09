require 'pry'

class Bitmap
  def initialize(width:, height:)
    @rows = (1..height).map do
      Array.new(width, 'O')
    end
  end

  def to_s
    @rows.reverse.map{ |row| row.join }.join("\n")
  end
end
