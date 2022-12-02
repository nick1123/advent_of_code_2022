shape_selected_scoring = {'rock' => 1, 'paper' => 2, 'scissors' => 3}

round_scoring = {
  'rock'     => {'rock' => 3, 'paper' => 6, 'scissors' => 0},
  'paper'    => {'rock' => 0, 'paper' => 3, 'scissors' => 6},
  'scissors' => {'rock' => 6, 'paper' => 0, 'scissors' => 3}
}

translator_1 = {'A' => 'rock', 'B' => 'paper', 'C' => 'scissors'}

translator_2 = {'X' => 'lose', 'Y' => 'draw', 'Z' => 'win'}

translator_3 = {
  'win'  => {'rock' => 'paper',    'paper' => 'scissors', 'scissors' => 'rock'},
  'draw' => {'rock' => 'rock',     'paper' => 'paper',    'scissors' => 'scissors'},
  'lose' => {'rock' => 'scissors', 'paper' => 'rock',     'scissors' => 'paper'},
}

sum = 0
IO.readlines("input.txt").each do |line|
  opponent, outcome = line.strip.split(/\s+/)
  opponent = translator_1[opponent]
  outcome = translator_2[outcome]
  me = translator_3[outcome][opponent]
  sum += round_scoring[opponent][me] + shape_selected_scoring[me]
end

puts sum
