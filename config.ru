require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require_relative './helpers/deposit_calculator.rb'
require_relative './app.rb'
run Application
