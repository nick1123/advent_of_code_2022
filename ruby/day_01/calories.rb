max = 0
raw = IO.read('calories.txt')
raw.split("\n\n").each do |values|
  sum = values.split(/\s+/).map {|v| v.to_i}.sum
  max = sum if sum > max
end

puts max