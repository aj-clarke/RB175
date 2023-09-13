require_relative 'monroe'
require_relative 'advice'

class App < Monroe
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      # template = File.read("views/index.erb")
      # content = ERB.new(template)
      # [
      #  '200',
      #  { 'Content-Type' => 'text/html' },
      #  [erb(:index)]     # was [content.result]
      # ]
      status = '200'
      headers = { 'Content-Type' => 'text/html' }
      response(status, headers) do
        erb :index
      end
    when '/advice'
      piece_of_advice = Advice.new.generate # random piece of advice
      # [
      #   '200',
      #   { 'Content-Type' => 'text/html' },
      #   [erb(:advice, message: piece_of_advice)]
      # ]
      status = '200'
      headers = { 'Content-Type' => 'text/html' }
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      # [
      #   '404',
      #   { 'Content-Type' => 'text/html', 'Content-Length' => '61' },
      #   [erb(:not_found)]
      # ]
      status = '404'
      headers = { 'Content-Type' => 'text/html', 'Content-Length' => '81' }
      response(status, headers) do
        erb :not_found
      end
    end
  end
end
