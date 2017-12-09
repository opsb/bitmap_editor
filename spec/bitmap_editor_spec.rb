require "spec_helper"
require "bitmap_editor"

describe BitmapEditor do
  def self.example(description, commands:, expected:)
    describe description do
      specify do
        output = StringIO.new
        BitmapEditor.new.process_commands(commands, output)

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
end
