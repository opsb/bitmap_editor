require "spec_helper"
require "bitmap_editor"

describe BitmapEditor do
  def self.example(description, commands:, expected:)
    describe description do
      specify do
        output = StringIO.new

        Tempfile.create("commands") do |file|
          file.write(commands.join("\n"))
          file.rewind
          BitmapEditor.new.run(file, output)

          expect(output.string).to eq(expected)
        end
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

  example("from technical test document",
    commands: [
      "I 5 6",
      "L 1 3 A",
      "V 2 3 6 W",
      "H 3 5 2 Z",
      "S"
    ],

    expected: <<~OUTPUT
      OOOOO
      OOZZZ
      AWOOO
      OWOOO
      OWOOO
      OWOOO
    OUTPUT
  )

  example("fail fast when command is attempted before image has been created",
    commands: [
      "S",
      "I 6 6",
      "S"
    ],

    expected: <<~OUTPUT
      There is no image
    OUTPUT
  )

  example("fail fast when command is not recognised",
    commands: [
      "Boom",
      "I 6 6",
      "S"
    ],

    expected: <<~OUTPUT
      unrecognised command :(
    OUTPUT
  )
end
