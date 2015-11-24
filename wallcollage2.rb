#!/usr/bin/env ruby
=begin
@author:       Robert Waffen <rwaffen@gmail.com>
@version:      0.2.0
@ruby:         2.2.3p173
=end

require_relative 'lib/Bootstrap'
@logger = RobLog.new.get_logger('Main')

pp Choice.choices if Choice[:debug]

Wallcollage.new.create_collage(
    Choice[:path],
    Choice[:quantity],
    Choice[:width],
    Choice[:height],
    Choice[:name]
)