require 'socket'
class Http

  attr_reader :tcp_server, :counter
  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
  end

  def listen_and_respond
    while client = tcp_server.accept
      puts "ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      response = "<pre>" + request_lines.join("\n") + "</pre>"
      verb = request_lines[0].split[0]
      path = request_lines[0].split[1]
      protocol = request_lines[0].split[2]
      host = request_lines[1].split[1]
      port = request_lines[1].split(":")[2]
      origin = request_lines[1].split[1]
      accept = request_lines[6]

      header = <<END_OF_HEADERS
      <pre>
      Verb: #{verb}
      Path: #{path}
      Protocol: #{protocol}
      Host: #{host}
      Port: #{port}
      Origin: #{origin}
      Accept: #{accept}
END_OF_HEADERS

      response = header
      output = "<html><head></head><body>#{header}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.print output
    end
    client.close
  end
end
http = Http.new
http.listen_and_respond