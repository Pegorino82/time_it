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
    return response(405, 'Method not allowed') unless @env['REQUEST_METHOD'] == 'GET'

    response(400, 'Format param expected') if time_format.nil?
  end

  def time_request
    datetime = DateTimeService.new(time_format)
    return response(400, "Unknown time format #{datetime.wrong_params}") unless datetime.valid?

    response(200, datetime.make_datetime)
  end

  def response(status, body)
    [status, {}, ["#{body}\n"]]
  end

  def time_format
    Rack::Utils.parse_query(@env['QUERY_STRING'])['format']
  end
end
