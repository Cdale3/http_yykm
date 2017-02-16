# require 'minitest/capybara'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'faraday'

require './lib/iteration_zero'

class IterationZeroTest < Minitest::Test 

	def test_it_exists
		IterationZero.new.is_a? IterationZero
	end

	def test_will_respond_to_an_http_request
 		%x( pwd )
		# server = IterationZero.new
		# server.listen_and_respond(9292)
		response = Faraday.get("http://127.0.0.1:9292/")

		assert_equal response.body, "..."
	 end

end