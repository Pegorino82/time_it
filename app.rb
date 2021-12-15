require_relative 'handlers/date_time_handler'
require_relative 'response'
require 'rack'

ROUTES = {
  '/time' => DateTimeHandler
}

class App
  include Response

  def call(env)
    handler_class = ROUTES[env['REQUEST_PATH']]
    if handler_class.nil?
      response(404, 'Not found')
    else
      handler = handler_class.new
      handler.handle(env)
    end
  end
end
