require "spec_helper"
require "bitmap_editor/bitmap"

describe Bitmap do
  describe :color_pixel do
    let(:blank_bitmap) { Bitmap.new(width: 6, height: 4) }

    context "for valid coordinates" do
      subject(:bitmap) { blank_bitmap.color_pixel(x: 1, y: 3, color: "A") }

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

    context "for invalid x" do
      specify do
        expect {
          blank_bitmap.color_pixel(x: 10, y: 3, color: "A")
        }.to raise_error("Invalid x: 10")
      end
    end

    context "for invalid y" do
      specify do
        expect {
          blank_bitmap.color_pixel(x: 5, y: 10, color: "A")
        }.to raise_error("Invalid y: 10")
      end
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

  describe :draw_horizontal_segment do
    subject(:bitmap) do
      Bitmap.new(width: 6, height: 6)
        .draw_horizontal_segment(y: 1, x1: 1, x2: 4, color: "A")
    end

    specify do
      expect(subject.to_s).to eq(
        <<~BITMAP
          AAAAOO
          OOOOOO
          OOOOOO
          OOOOOO
          OOOOOO
          OOOOOO
        BITMAP
        .strip
      )
    end
  end

  describe "immutability" do
    specify do
      blank_bitmap = Bitmap.new(width: 6, height: 6)
      with_pixel = blank_bitmap.color_pixel(x: 1, y: 3, color: "A")
      expect(with_pixel.to_s).to_not eq(blank_bitmap.to_s)
    end
  end
end
