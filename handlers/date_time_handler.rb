require_relative '../services/date_time_service'
require_relative 'base_handler'

class DateTimeHandler < BaseHandler
  def get
    params = query_params['format'].split(',')
    return response(400, "Format param expected") if params.nil?

    datetime = DateTimeService.new(params)
    return response(400, "Unknown time format #{datetime.wrong_params}") unless datetime.valid?

    response(200, datetime.make_datetime)
  end
end


