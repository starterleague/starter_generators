require 'rails/generators/active_record'
require_relative './migration'
module Starter
  class ResourceGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    include Rails::Generators::ResourceHelpers
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
    remove_class_option :old_style_hash
    remove_class_option :force_plural
    remove_class_option :skip_namespace
    class_option :named_routes, :type => :boolean, :default => true
    class_option :skip_model, :type => :boolean, :default => false
    class_option :skip_controller, :type => :boolean, :default => false
    class_option :styled, :type => :boolean, :default => false, desc: 'Generates bootstrap-ready view templates'
    class_option :dry, :type => :boolean, :default => false, desc: 'DRYs up the controller, views, and routes'

    def generate_controller
      return if options[:skip_controller]
      if dry?
        template 'dried/controller.rb', "app/controllers/#{plural_name.underscore}_controller.rb"
      else
        template 'controller.rb', "app/controllers/#{plural_name.underscore}_controller.rb"
      end
    end

    def generate_model
      return if options[:skip_model]
      template 'model.rb', "app/models/#{singular_name.underscore}.rb"
    end

    def generate_migration
      return if options[:skip_model]
      migration_template "migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    # def create_root_view_folder
    #   empty_directory File.join("app/views", controller_file_path)
    # end

    def copy_view_files
      available_views.each do |view|
        filename = view_filename_with_extensions(view)
        template filename, File.join("app/views", controller_file_path, File.basename(filename))
      end
    end


    def generate_routes
      return if options[:skip_controller]
      if dry?
        route "resources :#{plural_name}", "Named RESTful routes"
      elsif named_routes?
        route golden_7_named, "Named RESTful routes"
      else
        route golden_7, "RESTful routes"
      end
    end

  protected

    def golden_7
      ["# Routes for the #{singular_name.capitalize} resource:",
          "  # CREATE",
          "  get '/#{plural_name}/new', controller: '#{plural_name}', action: 'new'",
          "  post '/#{plural_name}', controller: '#{plural_name}', action: 'create'",
          "",
          "  # READ",
          "  get '/#{plural_name}', controller: '#{plural_name}', action: 'index'",
          "  get '/#{plural_name}/:id', controller: '#{plural_name}', action: 'show'",
          "",
          "  # UPDATE",
          "  get '/#{plural_name}/:id/edit', controller: '#{plural_name}', action: 'edit'",
          "  patch '/#{plural_name}/:id', controller: '#{plural_name}', action: 'update'",
          "",
          "  # DELETE",
          "  delete '/#{plural_name}/:id', controller: '#{plural_name}', action: 'destroy'",
          "  ##{'-' * 30}"
        ].join("\n")
    end

    def golden_7_named
      ["# Routes for the #{singular_name.capitalize} resource:",
        "  # CREATE",
        "  get '/#{plural_name}/new', controller: '#{plural_name}', action: 'new', as: 'new_#{singular_name}'",
        "  post '/#{plural_name}', controller: '#{plural_name}', action: 'create', as: '#{plural_name}'",
        "",
        "  # READ",
        "  get '/#{plural_name}', controller: '#{plural_name}', action: 'index'",
        "  get '/#{plural_name}/:id', controller: '#{plural_name}', action: 'show', as: '#{singular_name}'",
        "",
        "  # UPDATE",
        "  get '/#{plural_name}/:id/edit', controller: '#{plural_name}', action: 'edit', as: 'edit_#{singular_name}'",
        "  patch '/#{plural_name}/:id', controller: '#{plural_name}', action: 'update'",
        "",
        "  # DELETE",
        "  delete '/#{plural_name}/:id', controller: '#{plural_name}', action: 'destroy'",
        "  ##{'-' * 30}"
        ].join("\n")
    end

    def dry?
      options[:dry]
    end

    def named_routes?
      options[:named_routes]
    end

    def styled?
      options[:styled]
    end

    # Override of Rails::Generators::Actions
    def route(routing_code, title)
      log :route, title
      sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/

      in_root do
        inject_into_file 'config/routes.rb', "\n  #{routing_code}\n", { :after => sentinel, :verbose => false }
      end
    end

    def attributes_with_index
      attributes.select { |a| a.has_index? || (a.reference? && options[:indexes]) }
    end

    def available_views
      dry? ? %w(index new edit show _form) : %w(index new edit show)
    end

    def view_filename_with_extensions(name)
      filename = [name, :html, :erb].compact.join(".")
      folders = []
      folders << 'dried' if dry?
      folders << 'bootstrapped' if styled?
      filename = File.join(folders, filename) if folders.any?
      return filename
    end
  end
end
