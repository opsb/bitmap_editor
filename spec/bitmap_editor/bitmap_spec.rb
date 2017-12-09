require "spec_helper"
require "bitmap_editor/bitmap"

describe Bitmap do
  describe :color_pixel do
    subject(:bitmap) do
      Bitmap.new(width: 6, height: 4)
        .color_pixel(x: 1, y: 3, color: "A")
    end

    specify do
      expect(subject.to_s).to eq(
        <<~BITMAP
          OOOOOO
          OOOOOO
          AOOOOO
          OOOOOO
        BITMAP
        .strip
      )
    end
  end

  describe :draw_vertical_segment do
    subject(:bitmap) do
      Bitmap.new(width: 6, height: 6)
        .draw_vertical_segment(x: 1, y1: 1, y2: 4, color: "A")
    end

    specify do
      expect(subject.to_s).to eq(
        <<~BITMAP
          AOOOOO
          AOOOOO
          AOOOOO
          AOOOOO
          OOOOOO
          OOOOOO
        BITMAP
        .strip
      )
    end
  end
end
