#!/usr/bin/env ruby

# Reverse the order of that length of elements in the list, starting with the element at the current position.
# Move the current position forward by that length plus the skip size.
# Increase the skip size by one.

input = File.read('input.txt')
list = (0...256).to_a

current = 0
skip = 0
lengths = input.split(',').map(&:to_i)

lengths.each do |n|
  # update current position
  list.rotate!(current)

  list = list.shift(n).reverse + list

  list.rotate!(-current)

  current += n + skip

  # increate skip
  skip += 1
end

p list.take(2).reduce(:*)
