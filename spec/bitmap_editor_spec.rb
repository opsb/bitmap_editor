require "spec_helper"
require "bitmap_editor"

describe BitmapEditor do
  def self.example(description, commands:, expected:)
    describe description do
      specify do
        output = StringIO.new
        BitmapEditor::CommandProcessor.new(output).process(commands)

        expect(output.string).to eq(expected)
      end
    end
  end

  example("print before bitmap has been created",
    commands: [
      "S"
    ],

    expected: <<~OUTPUT
      There is no image
    OUTPUT
  )

  example("create blank bitmap",
    commands: [
      "I 6 3",
      "S"
    ],

    expected: <<~OUTPUT
      OOOOOO
      OOOOOO
      OOOOOO
    OUTPUT
  )

  example("color a pixel",
    commands: [
      "I 6 3",
      "L 1 3 A",
      "S"
    ],

    expected: <<~OUTPUT
      OOOOOO
      OOOOOO
      AOOOOO
    OUTPUT
  )

  example("draw a vertical segment",
    commands: [
      "I 6 6",
      "V 2 2 5 F",
      "S"
    ],

    expected: <<~OUTPUT
      OOOOOO
      OFOOOO
      OFOOOO
      OFOOOO
      OFOOOO
      OOOOOO
    OUTPUT
  )

  example("draw a horizontal segment",
    commands: [
      "I 6 6",
      "H 2 5 2 F",
      "S"
    ],

    expected: <<~OUTPUT
      OOOOOO
      OFFFFO
      OOOOOO
      OOOOOO
      OOOOOO
      OOOOOO
    OUTPUT
  )
end
