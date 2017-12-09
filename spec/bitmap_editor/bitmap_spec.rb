require "spec_helper"
require "bitmap_editor/bitmap"

describe Bitmap do
  describe "color_pixel" do
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
end
