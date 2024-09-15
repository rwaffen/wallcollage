#!/usr/bin/env ruby
=begin
@author:       Robert Waffen <rwaffen@gmail.com>
@version:      0.2.0
@ruby:         2.2.3p173
=end

require_relative 'lib/bootstrap'

create_collage(
  @options[:path],
  @options[:quantity],
  @options[:width],
  @options[:height],
  @options[:border],
  @options[:resolution],
  @options[:debug],
)
