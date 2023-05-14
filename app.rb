# frozen_string_literal: true

require 'yaml'

require_relative './lib/router'
require_relative './lib/boot'

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)

    [result.status, result.headers, result.content]
  end

  def self.root
    File.dirname(__FILE__)
  end
end
