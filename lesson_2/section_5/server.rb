require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split
  path, params = path_and_params.split("?")

  params = params.split("&").each_with_object(Hash.new(0)) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  # Read Notes on the Bottom that were located HERE

  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts "http_method is: #{http_method}"
  client.puts "path is: #{path}"
  client.puts "params are: #{params}"
  client.puts "</pre>"

  client.puts "<h1>Rolls!</h1>"
  
  rolls = params["dice"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides) + 1
    client.puts "<p>", roll, "</p>"
  end

  client.puts "</body>"
  client.puts "</html>"
  client.close
end

=begin
would like to have a hash key/value pair for query param/values
  - also need variables for the assignment of data coming in

# GET /?dice=2&sides=6 HTTP/1.1

http_method == "GET"
path == "/"
params == { "rolls" => "2", "sides" => "6" }

  # request_split = request_line.split
  # query_split = request_split[1].split("&")
  # params = {"dice" => query_split[0][-1], "sides" => query_split[1][-1] }
  # http_method = request_split[0]

  # REFACTORING ABOVE

  # Start with: # GET /?dice=2&sides=6 HTTP/1.1
  # http_method, path_and_params, http = request_line.split

  # http_method and http are done
  # Left with:
  # path_and_params > /?dice=2&sides=6
  # path, queries = path_and_params.split("?")

  # path is done
  # Left with:
  # queries > dice=2&sides=6
  # queries = queries.split("&")

  # Left with:
  # queries > [dice=2, sides=6]

  # queries.each_with_object(params = Hash.new(0)) do |pair|
  #   key, value = pair.split("=")
  #   params[key] = value
  # end
=end