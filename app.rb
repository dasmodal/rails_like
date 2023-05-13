# frozen_string_literal: true

require 'yaml'

require './lib/router'

# require all lib .rb files
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each { |file| require_relative file }
# require all controllers .rb files
Dir[File.join(File.dirname(__FILE__), 'app', 'controllers', '*.rb')].each { |file| require_relative file }

ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), 'app', 'routes.yml')))

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    binding.irb
    result = router.resolve(env)

    [result.status, result.headers, result.content]
  end
end
