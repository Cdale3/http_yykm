require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'

class HTTPTest < Minitest::Test

  def test_can_get_debugger
    response = Faraday.get 'http://127.0.0.1:9292/'
    expected = "<html><head></head>\n<body>   \n<pre>Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort:9292\nOrigin: 127.0.0.1\nAccept: */*</pre>\n</body>\n</html>"
    assert expected, response.body
  end

  def test_can_respond_with_200_status
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 200, response.status
  end


  def test_can_return_datetime
    skip
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    assert response.body.include?("2017")
  end

  def test_can_retrieve_a_word_in_dictionary
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=aardvark'
    assert response.body.include?("AARDVARK is a known word")
  end

  def test_unknown_page_returns_blank
    response = Faraday.get 'http://127.0.0.1:9292/gooooop'
    expected = "<html><head></head><body></body></html>"
    assert_equal expected, response.body
  end

  def test_zzz_can_it_can_return_total_request_phrase
    skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'

    assert response.body.include?("All Requests:")
  end
end