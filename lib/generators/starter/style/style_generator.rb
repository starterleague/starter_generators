module Starter
  class StyleGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :theme_name, :type => :string#, :default => 'default'

    class_option :layout, :type => :boolean, :default => true, :desc => "Generate a new application layout."
    class_option :navbar, :type => :boolean, :default => true, :desc => "Generate a model-based navbar."
    argument :layout_file, :type => :string, :default => 'application', :desc => "Layout filename"

    def inject_styles
      template 'bootstrap_overrides.css', 'app/assets/stylesheets/bootstrap_overrides.css', verbose: false

      if bootswatch_theme?
        log :insert, "Bootswatch theme '#{theme_name}'"
        inject_into_file "app/assets/stylesheets/application.css", "\n *= require bootstrap_overrides\n", before: /^\s*\*\//, verbose: false
        log :insert, 'Bootstrap customizations'
        gsub_file 'app/assets/stylesheets/application.css', /^\s*\*= require bootstrap.min \./, ''

      else
        gsub_file 'app/assets/stylesheets/application.css', /^\s*\*= require_tree \./, ''
        template 'bootstrap.min.css', 'app/assets/stylesheets/bootstrap.min.css', verbose: false
        inject_into_file "app/assets/stylesheets/application.css", " *= require bootstrap.min\n", before: /^\s*\*\//, verbose: false
        log :insert, 'Bootstrap CSS framework'
        inject_into_file "app/assets/stylesheets/application.css", " *= require bootstrap_overrides\n", before: /^\s*\*\//, verbose: false
        log :insert, 'Bootstrap customizations'
      end

      log :insert, 'FontAwesome support'

      template 'bootstrap.min.js', 'app/assets/javascripts/bootstrap.min.js', verbose: false
      inject_into_file 'app/assets/javascripts/application.js',
                       "\n//= require bootstrap.min",
                       after: /^\/\/= require jquery$/,
                       verbose: false
    end

    def generate_layout
      template "layout.html.erb", "app/views/layouts/#{layout_file}.html.erb" if options[:layout]
    end

  protected

    def bootswatch_theme?
      if theme_name.present?
        (theme_name.downcase != 'default') && (theme_name.downcase != 'd')
      end
    end

    def app_tables
      ActiveRecord::Base.connection.tables - ['schema_migrations']
    end

    def application_name
      if defined?(Rails) && Rails.application
        Rails.application.class.name.split('::').first.humanize.titleize
      else
        "application"
      end
    end

    def available_styles
      Dir["bootstrap-css/*"].entries.push('default')
    end
  end
end
