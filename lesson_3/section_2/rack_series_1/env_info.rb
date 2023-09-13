require 'rack'
class MyApp
  def call(env)
    puts inspect_env(env)
    ['200', { "Content-Type" => "text/plain" }, ["Yay, your first web app! <3"]]
  end

  def inspect_env(env)
    puts format('Request headers', request_headers(env))
    puts format('Server info', server_info(env))
    puts format('Rack info', rack_info(env))
  end

  def request_headers(env)
    env.select { |key, _| key.include?('HTTP_') }
  end

  def server_info(env)
    env.reject { |key, _| key.include?('rack.') || key.include?('HTTP_')}
  end

  def rack_info(env)
    env.select { |key, _| key.include?('rack.')}
  end

  def format(heading, pairs)
    [heading, "", format_pairs(pairs), "\n"].join("\n")
  end

  def format_pairs(pairs)
    pairs.map { |key, value| '  ' + [key, value.inspect].join(': ')}
  end
end
Rack::Handler::WEBrick.run MyApp.new