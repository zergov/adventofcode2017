#!/usr/bin/env ruby

# Reverse the order of that length of elements in the list, starting with the element at the current position.
# Move the current position forward by that length plus the skip size.
# Increase the skip size by one.

def knot_hash(input)
  list = (0...256).to_a
  current = 0
  skip = 0
  lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]

  64.times do
    lengths.each do |n|
      # update current position
      list.rotate!(current)

      list = list.shift(n).reverse + list

      list.rotate!(-current)

      current += n + skip

      # increate skip
      skip += 1
    end
  end

  # sparse hash
  16.times
    .map { list.shift(16).reduce(:^) }
    .map {|x| x.to_s(16).rjust(2, '0')}
    .join
end


input = File.read('input.txt').strip

#part 1
# p knot_hash(input).chars.take(2).map(&:to_i).reduce(:*)
p knot_hash(input)
