def read_input
  IO.readlines("input.txt").map(&:strip)
end

def split_in_2_compartments(line)
  line.split('').each_slice(line.size / 2).map(&:join)
end

def convert_letter(char)
  ord = char.ord
  if ord >= 97
    ord - 96
  else
    ord - 38
  end
end

def convert_to_numeric_values(line)
  line.split('').map {|char| convert_letter(char)}
end

def part_1
  lines = read_input
  pp (lines.map do |line|
      split_in_2_compartments(line)
    end.map do |comp1, comp2|
      [convert_to_numeric_values(comp1), convert_to_numeric_values(comp2)]
    end.map do |comp1, comp2|
      comp1.intersection(comp2)
    end.flatten.sum)
end

##################################################

def part_2
  lines = IO.readlines("input2.txt").map(&:strip)
  # pp lines

  pp (IO.readlines("input2.txt").map(&:strip).each_slice(3).map do |row1,row2,row3|
     [row1,row2,row3]
   end.map do |row1,row2,row3|
     row1.split('').intersection(row2.split('')).intersection(row3.split(''))
   end.flatten.map do |char|
    convert_letter(char)
   end.sum)
end

##################################################

part_1
part_2