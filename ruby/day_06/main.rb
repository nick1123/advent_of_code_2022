def read_input
  IO.read("input.txt")
end

def part_1(n=4)
  chars = read_input.split("")

  0.upto(chars.size) do |index|
    return index + n if chars.slice(index, n).uniq.size == n
  end
end

def part_2
  part_1(14)
end

puts part_1
puts part_2