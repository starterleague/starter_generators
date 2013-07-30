require 'starter_generators'
require 'rails'

module StarterGenerators
  class Railtie < Rails::Railtie
    railtie_name :starter

    rake_tasks do
      load "tasks/starter.rake"
    end
  end
end
