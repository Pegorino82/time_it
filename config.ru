# frozen_string_literal: true

require_relative 'middleware/logger'
require_relative 'app'

ROUTES = {
  '/time' => App.new
}.freeze

use Rack::ContentType, 'text/plain'
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run Rack::URLMap.new(ROUTES)
