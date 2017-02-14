require './lib/iteration_zero'

server = IterationZero.new
server.listen_and_response(9292)