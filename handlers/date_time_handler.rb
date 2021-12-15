require_relative '../services/date_time_service'
require_relative '../response'

class DateTimeHandler
  include Response

  def handle(env)
    @env = env
    method = @env['REQUEST_METHOD'].downcase.to_sym
    return response(404, 'Not found') unless self.class.method_defined?(method)
    send(method)
  end

  def get
    params = query_params['format'].split(',')
    return response(400, "Format param expected") if params.nil?

    datetime = DateTimeService.new(params)
    return response(400, "Unknown time format #{datetime.wrong_params}") unless datetime.valid?

    response(200, datetime.make_datetime)
  end

  private

  def query_params
    @env['QUERY_STRING'].split('&').map { |value| value.split('=') }.to_h
  end
end


