require 'lib/transformations.rb'
require 'app/transformations.rb'

def tick(args)
  if $example
    $example.tick(args)

    $example = nil if args.inputs.keyboard.key_down.escape
  else
    render_menu(args)
  end
end

EXAMPLES = [
  { name: 'Transformations', example: TransformationsExample.new }
]

BUTTONS = ('a'..'z').to_a

def render_menu(args)
  args.outputs.labels << { x: 400, y: 650, text: "Examples", size_enum: 2 }

  y = 600
  EXAMPLES.each.with_index do |example, i|
    button = BUTTONS[i]
    args.outputs.labels << [400, y, "#{button}) #{example[:name]}"]

    if args.inputs.keyboard.key_down.send("#{button}!") # Use ! method to consume key event
      $example = example[:example]
      $gtk.reset
    end

    y -= 24
  end

  args.outputs.labels << [10, 30, 'Press Escape inside an example to return to the menu']
end
