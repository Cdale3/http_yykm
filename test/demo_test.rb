require 'minitest/capybara'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'faraday'

require './lib/iteration_zero'

class IterationZeroTest < Minitest::Capybara::Test 
	
		def test_it_gets_hello_world
			 visit "http://127.0.0.1:9292/"	

			 assert_content "Hello World"	
		end
end
#Capybara error: since this isn't a rails project, rack_test driver errors in console. Unsure how to resolve.