def read_input
  IO.read("input.txt")
end

def alpha?(char)
  char.ord >= 65 && char.ord <= 90
end

def parse_stack_number(index)
  (index + 3) / 4
end

# Ex: {2=>["D", "C", "M"], 1=>["N", "Z"], 3=>["P"]}
def parse_diagram
  lines = read_input.split("\n\n")[0].split("\n")

  # Remove bottom line `1   2   3 `
  lines.pop

  stacks = {}

  lines.each do |line|
    line.split("").each_with_index do |char, index|
      next unless alpha?(char)

      stack_number = parse_stack_number(index)
      stacks[stack_number] ||= []
      stacks[stack_number] << char
    end
  end

  stacks
end

# Ex: [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
def parse_instructions
  read_input.split("\n\n")[1].split("\n").map do |line|
    chunks = line.strip.split(/\s+/)
    [chunks[1], chunks[3], chunks[5]].map(&:to_i)
  end
end

def run(stacks, instructions)
  instructions.each do |iterations, from_stack, to_stack|
    iterations.times do
      stacks[to_stack].unshift(stacks[from_stack].shift)
    end
  end
end

def top_of_each_stack(stacks)
  stacks.keys.sort.map do |index|
    stacks[index][0]
  end.join
end

def part_1
  instructions = parse_instructions
  stacks = parse_diagram
  run(stacks, instructions)
  puts top_of_each_stack(stacks)
end

##########################################

def run2(stacks, instructions)
  instructions.each do |iterations, from_stack, to_stack|
    tmp_stack = []
    iterations.times do
      tmp_stack << stacks[from_stack].shift
    end

    iterations.times do
      stacks[to_stack].unshift(tmp_stack.pop)
    end
  end
end

def part_2
  instructions = parse_instructions
  stacks = parse_diagram
  run2(stacks, instructions)
  puts top_of_each_stack(stacks)
end

part_1
part_2
