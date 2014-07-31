require 'spec_helper'
require 'pry'
require "#{File.expand_path(File.dirname(__FILE__))}/../handmade_set.rb"
require "#{File.expand_path(File.dirname(__FILE__))}/support/custom_matcher_helper.rb"

RSpec.configure do |config|
  config.order = :random
  Kernel.srand config.seed
end
