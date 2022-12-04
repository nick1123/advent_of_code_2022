def part_1
  pp (IO.readlines("input.txt").map do |line|
    line.strip.split(',').map {|range| range.split('-').map {|n| n.to_i}}
  end.select do |range1,range2|
    ((range1[0] <= range2[0]) && (range1[1] >= range2[1])) ||
    ((range2[0] <= range1[0]) && (range2[1] >= range1[1]))
  end.size)
end

#############################

def part_2
  pp (IO.readlines("input.txt").map do |line|
    line.strip.split(',').map {|range| range.split('-').map {|n| n.to_i}}.map {|a,b| (a..b).to_a}
  end.select do |array1,array2|
    array1.intersection(array2).size > 0
  end.size)
end

#############################

part_1
part_2