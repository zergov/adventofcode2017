#!/usr/bin/env ruby

class Layer
  attr_accessor :location, :range, :depth

  def initialize(depth, range)
    @range = range
    @depth = depth
    @location = 0
    @velocity = 1
  end

  def update
    @location = @location + @velocity

    if @location == 0
      @velocity = 1
    elsif @location == @range - 1
      @velocity = -1
    end
  end
end


def part1
  layers = {}
  File.readlines('input.txt').each do |line|
    depth, range = line.split(':').map(&:strip).map(&:to_i)
    layers[depth] = Layer.new(depth, range)
  end

  position = 0
  destination = layers.keys.max
  severity = 0
  until position > destination
    if layers.key?(position) && layers[position].location == 0
      severity = severity + (layers[position].range * position)
    end

    position = position + 1
    layers.each { |depth, layer| layer.update }
  end

  severity
end

def part2
  delay = 0
  layers = {}
  delayed_cache = {}

  File.readlines('input.txt').each do |line|
    depth, range = line.split(':').map(&:strip).map(&:to_i)
    layers[depth] = Layer.new(depth, range)
  end

  delayed_cache[delay] = layers.values.map(&:clone)

  loop {
    # Get layers at current delay
    layers = delayed_cache[delay].reduce({}) {|acc, layer| acc.merge(layer.depth => layer)}

    # increment the delay by 1
    delay = delay + 1
    layers.each { |_, layer| layer.update }

    # cache the layers at delay + 1
    delayed_cache[delay] = layers.values.map(&:clone)

    puts "delay = #{delay}" if delay % 1000 == 0

    position = 0
    destination = layers.keys.max
    severity = 0

    caught = false
    until position > destination
      if layers.key?(position) && layers[position].location == 0
        caught = true
        break
      end

      position = position + 1
      layers.each { |depth, layer| layer.update }
    end

    next if caught

    return delay
  }
end

p part1
p part2
