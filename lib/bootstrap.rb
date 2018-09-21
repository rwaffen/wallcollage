=begin
@author     Robert Waffen <rwaffen@gmail.com>

Loading all the dependencies. Using bundler for gems (see Gemfile).
=end

# gem dependencies
require 'rubygems'
require 'bundler'
Bundler.require(:default)

include Magick

# project dependencies
require_relative 'wallcollage'

# ruby libs
require 'securerandom'
require 'prime'
require 'pp'

# startup dependencies
require_relative 'OptionParser'
