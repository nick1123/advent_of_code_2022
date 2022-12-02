sums = []
raw = IO.read('calories.txt')
raw.split("\n\n").each do |values|
  sum = values.split(/\s+/).map {|v| v.to_i}.sum
  sums << sum
end

pp sums.sort.reverse[0,3].sum