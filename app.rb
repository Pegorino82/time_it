# frozen_string_literal: true

require_relative 'date_time_service'
require 'rack'

class App
  def call(env)
    @env = env
    error_request || time_request
  end

  private

  def error_request
    return response(404, 'Not found') unless @env['REQUEST_PATH'] == '/time'
    return response(405, 'Method not allowed') unless @env['REQUEST_METHOD'] == 'GET'
    return response(400, 'Format param expected') if time_format.nil?

    false
  end

  def time_request
    datetime = DateTimeService.new(time_format.split(','))
    return response(400, "Unknown time format #{datetime.wrong_params}") unless datetime.valid?

    response(200, datetime.make_datetime)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, body)
    [status, headers, ["#{body}\n"]]
  end

  def params
    Rack::Utils.parse_query(@env['QUERY_STRING'])
  end

  def time_format
    params['format']
  end
end
