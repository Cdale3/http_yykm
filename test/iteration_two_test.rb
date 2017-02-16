require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'faraday'

require 'pry'
class IterationTwoTest < Minitest::Test

	def test_that_root_responds_with_debug_info
		response  = Faraday.get('http://127.0.0.1:9292/')
		expected = "<html><head></head><body> <pre>Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: Faraday v0.11.0\nPort:\nOrigin: Faraday v0.11.0\nAccept: */*</pre></body></html>"
		assert_equal expected, response.body
	end

	def test_that_calls_to_hello_counter
		response  = Faraday.get('http://127.0.0.1:9292/hello')
		assert response.body.include?('Hello World! (1)'), "Expected #{response.body} to include 'Hello World! (1)'"

		response  = Faraday.get('http://127.0.0.1:9292/hello')
		assert response.body.include?('Hello World! (2)')

		response  = Faraday.get('http://127.0.0.1:9292/hello')
		refute response.body.include?('billybob squirrel')

	end

	 def test_responds_200
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 200, response.status
  end

  def test_can_return_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    
    assert response.body.include?("02")
    assert response.body.include?("2017")
    refute response.body.include?("2050")
  end

   def test_it_can_return_all_requests
    skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'

    assert response.body.include?("All Requests")
  end
end
