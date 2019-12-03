require "factory_bot"
# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
