require 'sinatra'
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

# main application (app.rb) file
require File.expand_path '../../helpers/deposit_calculator.rb', __FILE__
require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods

  def app
    Application.new
  end
end

RSpec.configure { |c| c.include RSpecMixin }
