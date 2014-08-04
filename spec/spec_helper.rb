require 'spec_helper'
require 'pry'
require "#{File.expand_path(File.dirname(__FILE__))}/../handmade_set.rb"
require "#{File.expand_path(File.dirname(__FILE__))}/../quick_sort.rb"

RSpec.configure do |config|
  ITEM_MAX = 10 ** 100
  INDEX_MAX = 10 ** 3

  config.order = :random
  Kernel.srand config.seed
end
