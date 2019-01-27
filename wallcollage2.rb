#!/usr/bin/env ruby
=begin
@author:       Robert Waffen <rwaffen@gmail.com>
@version:      0.2.0
@ruby:         2.2.3p173
=end

require_relative 'lib/Bootstrap'

pp Choice.choices if Choice[:debug]

if Choice[:resolution]
  case Choice[:resolution]
  when '4k'
    width  = 3840
    height = 2160
  when 'mbp'
    # make it a little bit smaller, to have the borders on display
    width  = 2559
    height = 1599
  when 'imac'
    width  = 2560
    height = 1440
  end
else
  width  = Choice[:width]
  height = Choice[:height]
end

puts "using  width: #{width}"  if Choice[:debug]
puts "using height: #{height}" if Choice[:debug]

Wallcollage.new.create_collage(
    Choice[:path],
    Choice[:quantity],
    width,
    height,
    Choice[:name]
)
