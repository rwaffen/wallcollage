#!/usr/bin/env ruby
=begin
@author:       Robert Waffen <rwaffen@gmail.com>
@version:      0.2.0
@ruby:         2.2.3p173
=end

require_relative 'lib/Bootstrap'

pp Choice.choices if Choice[:debug]

if Choice.choices.spcl24
  img = Imager.new
  img.create_blank_24
else
    Wallcollage.new.create_collage(
        Choice[:path],
        Choice[:quantity],
        Choice[:width],
        Choice[:height],
        Choice[:name]
    )
end