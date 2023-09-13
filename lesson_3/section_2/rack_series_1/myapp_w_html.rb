require 'rack'
class MyApp
  def call(env)
    body = "<h2>Hello in Style!</h2>"
    ['200', { "Content-Type" => "text/html" }, [body]]
  end
end
Rack::Handler::WEBrick.run MyApp.new