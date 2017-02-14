require 'socket'
require 'pry'
class IterationZero

	def listen_and_respond(port)
		@tcp_server = TCPServer.new(port)
		@client = @tcp_server.accept
		@counter = 0
		request_lines = []
		while line 		= @client.gets and !line.chomp.empty?
		  request_lines << line.chomp
		  @counter += 1
		end

		puts "Got this request:"
		puts request_lines.inspect

		verb = request_lines[0].split[0]
		path = request_lines[0].split[1]

		protocol = request_lines[0].split[2]
		
		response = "<pre>" + "Hello World" + "</pre>"
		output 	 = "<html><head></head><body>#{response}</body></html>"
		headers  = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
		@client.puts output
	end
end

server = IterationZero.new
server.listen_and_respond(9292)
#if running this file, keep lines 35 & 36, otherwise run interation_zero_test.rb
