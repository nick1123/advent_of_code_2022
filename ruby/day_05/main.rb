def read_input
  IO.read("input.txt")
end


def alpha?(char)
  char.ord >= 65 && char.ord <= 90
end

def parse_stack_number(index)
  (index + 3) / 4
end

def parse_diagram
  lines = read_input.split("\n\n")[0].split("\n")
  puts lines

  # Remove bottom line `1   2   3 `
  lines.pop

  stacks = {}

  lines.each do |line|
    # puts "***************"
    # pp line
    line.split("").each_with_index do |char, index|
      next unless alpha?(char)
      stack_number = parse_stack_number(index)
      # puts '-'
      # puts char
      # puts stack_number

      stacks[stack_number] ||= []
      stacks[stack_number] << char

    end
  end

  puts "------------------"
  # puts lines
  pp stacks
end

def parse_instructions
  read_input.split("\n\n")[1].split("\n")
end

def part_1
  instructions = parse_instructions
  parse_diagram
  # pp instructions
end

part_1