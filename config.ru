require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require_relative './app.rb'
run Application
