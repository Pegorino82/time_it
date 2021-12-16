# frozen_string_literal: true

class DateTimeService
  attr_reader :params, :params_available

  DATE_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d'
  }.freeze

  TIME_FORMATS = {
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(params)
    @params = params
    @params_available = DATE_FORMATS.keys + TIME_FORMATS.keys
  end

  def valid?
    @params.map { |param| @params_available.include?(param) }.all?
  end

  def wrong_params
    @params.map { |param| param unless @params_available.include?(param) }.compact!.to_s
  end

  def make_datetime
    date_string = @params.map { |param| DATE_FORMATS[param] }.compact.join('-')
    time_string = @params.map { |param| TIME_FORMATS[param] }.compact.join(':')
    Time.now.strftime("#{date_string} #{time_string}".strip)
  end
end
