require 'rubygems'
# require 'spec'
require 'stringio'
lib_dir = File.dirname(__FILE__) + "/../lib"
$:.unshift lib_dir unless $:.include?(lib_dir)
require 'maruku'
