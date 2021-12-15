require_relative 'services/date_time_service'
require_relative 'handlers'

params = ["year", "month", "day", 'hour']
datetime = DateTimeService.new(params)

p datetime.valid?
p datetime.wrong_params
p datetime.make_datetime
# datetime.DATE_FORMATS

"%Y-%m-%d"
"%H"
p Time.now.strftime("%Y-%m-%d %H")