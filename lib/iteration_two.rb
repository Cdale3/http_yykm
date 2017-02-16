require 'pry'
require 'socket'

tcp_server = TCPServer.new(9292)
@hello_counter = 0
@request_total = 0
@server_exit = false


def diagnostics(request_lines, path)
  verb = request_lines[0].split[0]
  protocol = request_lines[0].split[2]
  host = request_lines[1].split(":")[1].lstrip
  port = request_lines[1].split(":")[2]
  origin = host
  accept = request_lines[-3].split[1]

  header_string =
  " <pre>Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort:#{port}\nOrigin: #{origin}\nAccept: #{accept}</pre>"
end

def hello
  @hello_counter += 1
  "<h1> Hello World! (#{@hello_counter}) </h1>"
end

def datetime
   " <h1>#{Time.now.strftime('%m %M %p on %A %B %w %Y')}</h1> "
end

def shutdown
  @server_exit = true
  " <h1>All Requests: #{@request_total} </h1> "
end

puts "Ready for request"
until @server_exit
  client = tcp_server.accept
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request: "
  puts request_lines.inspect

  path = request_lines[0].split[1]
  @request_total += 1


  case path
  when '/'
    response = diagnostics(request_lines, path)
  when '/hello'
    response = hello
  when '/datetime'
    response = datetime
  when '/shutdown'
    response = shutdown
  end
  puts "Sending response."

  output = "<html><head></head><body>#{response}</body></html>"
  headers = [ "http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby:",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:", headers, output].join("\n")
    puts "\nResponse done, now exiting. Goodbye!"
  end
client.close
