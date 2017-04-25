require 'rails/generators/rails/model/model_generator'
module Starter
  class ModelGenerator < Rails::Generators::ModelGenerator

    def generate_activeadmin
      invoke 'active_admin:resource', ["#{name}"]
    end

    def add_permit_params
      permit_columns = attributes.collect{|column| ":#{column.name}" }.join(', ')
      code = "\n\n permit_params " + permit_columns
      inject_into_file "app/admin/#{name.singularize}.rb", code, :after => /^ActiveAdmin.register #{name.classify} do/
    end

  end
end
