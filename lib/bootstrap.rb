=begin
@author     Robert Waffen <rwaffen@gmail.com>

Loading all the dependencies. Using bundler for gems (see Gemfile).
=end

# gem dependencies
require 'rubygems'
require 'bundler'
Bundler.require(:default)

# project dependencies
require_relative 'RobLog'
require_relative 'wallcollage'
# testing
require 'pp'

# startup dependencies
require_relative 'OptionParser'