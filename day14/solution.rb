#!/usr/bin/env ruby

input = "flqrgnkx" #File.read('input.txt').strip

grid = []
128.times.each do |n|
  key = "#{input}-#{n}"
  p key.chars.map {|x| x.hex.to_s(2).rjust(4, "0")}.join
end

p grid.flatten.join.count('1')
