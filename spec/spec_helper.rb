require "rspec"
require "pry"

PROJECT_ROOT = File.expand_path('../..', __FILE__)

$LOAD_PATH << File.join(PROJECT_ROOT, 'lib', '*.rb')

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |c|
  c.include Mocks
end
