require 'socket'
require 'pry'
class IterationZero

	def listen_and_respond(port)
		@tcp_server = TCPServer.new(port)
		@client = @tcp_server.accept
		@counter = 0
		request_lines = []
		while line 		= @client.gets and !line.chomp.empty?
		  @counter += 1
		  request_lines << line.chomp
		end

		puts "Got this request:"
		puts request_lines.inspect
		
		response = "<pre>" + "Hello World #{@counter}\n" + "</pre>"
		output 	 = "<html><head></head><body>#{response}</body></html>"
		headers  = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
		@client.puts output
	end

	def hello
    @counter += 1
    "<h1> Hello World! (#{@counter}) </h1>"
  end

	def datetime
   " <h1>#{Time.now.strftime('%m %M %p on %A %B %w %Y')}</h1> "
	end
end

# server = IterationZero.new
# server.listen_and_respond(9292)
#if running this file, keep two lines above, otherwise run interation_zero_test.rb
