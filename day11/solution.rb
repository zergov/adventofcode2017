#!/usr/bin/env ruby


def direction_to_cord(direction)
  case direction
  when "ne" then [1, 0, -1]
  when "n"  then [0, 1, -1]
  when "nw" then [-1, 1, 0]
  when "sw" then [-1, 0, 1]
  when "s"  then [0, -1, 1]
  when "se" then [1, -1, 0]
  end
end

def distance(a, b)
  x, y, z = a
  xx, yy, zz = b
  [(x - xx).abs, (y - yy).abs, (z - zz).abs].max
end

def part1(path)
  initial = [0, 0, 0]
  final = path.split(',')
    .map {|direction| direction_to_cord(direction)}
    .inject(initial) {|(x, y, z), (xx, yy, zz)| [x + xx, y + yy, z + zz]}

  distance(initial, final)
end

def part2(path)
  initial = [0, 0, 0]
  distances = []

  path.split(',')
    .map {|direction| direction_to_cord(direction)}
    .inject(initial) do |(x, y, z), (xx, yy, zz)|
      pos = [x + xx, y + yy, z + zz]
      distances << distance(initial, pos)
      pos
    end

  distances.max
end

p part1(File.read('input.txt').strip)
p part2(File.read('input.txt').strip)
