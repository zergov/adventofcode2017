#!/usr/bin/env ruby
require 'set'

# from my day 10 solution
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

grid = []
128.times.each do |n|
  key = knot_hash("#{input}-#{n}")
  grid << key.chars.map {|x| x.hex.to_s(2).rjust(4, "0")}.join
end

# part1
p grid.flatten.join.count('1')


def find_connections(start, grid, visited, current_area = Set.new)
  x, y = start

  # visit this dude
  visited << start
  current_area << start

  neighbors = [
    [x, y + 1], [x, y - 1],
    [x + 1, y], [x - 1, y],
  ]
    .select {|(x, y)| x < 128 && x >= 0 && y < 128 && y >= 0 }
    .select {|(x, y)| grid[y][x] == '1'}
    .select {|position| !visited.include?(position) }


  neighbors.each do |neighbor|
    find_connections(neighbor, grid, visited, current_area)
  end

  current_area
end

# part2
area_count = 0
visited = Set.new
128.times do |y|
  128.times do |x|
    next if grid[y][x] == '0' || visited.include?([x, y])

    connections = find_connections([x, y], grid, visited)
    area_count += 1 if connections.size >= 1
  end
end

# part2
p area_count
