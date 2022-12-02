shape_selected_scoring = {'X' => 1, 'Y' => 2, 'Z' => 3}

round_scoring = {
  'A' => {'X' => 3, 'Y' => 6, 'Z' => 0},
  'B' => {'X' => 0, 'Y' => 3, 'Z' => 6},
  'C' => {'X' => 6, 'Y' => 0, 'Z' => 3}
}

sum = 0
IO.readlines("input.txt").each do |line|
  opponent, me = line.strip.split(/\s+/)
  sum += round_scoring[opponent][me] + shape_selected_scoring[me]
end

puts sum