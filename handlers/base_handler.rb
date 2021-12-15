require_relative '../response'

class BaseHandler
  include Response

  def handle(env)
    @env = env
    method = @env['REQUEST_METHOD'].downcase.to_sym
    return response(404, 'Not found') unless self.class.method_defined?(method)
    send(method)
  end

  private

  def query_params
    @env['QUERY_STRING'].split('&').map { |value| value.split('=') }.to_h
  end
end
