module Starter
  class StyleGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :bootswatch_name, :type => :string#, :default => 'spacelab'

    class_option :layout, :type => :boolean, :default => true, :desc => "Generate a new application layout."
    class_option :navbar, :type => :boolean, :default => true, :desc => "Generate a model-based navbar."
    argument :layout_file, :type => :string, :default => 'application', :desc => "Layout filename"

    def inject_styles
      template "bootstrap-css/#{bootswatch_name}.min.css", "app/assets/stylesheets/#{bootswatch_name}.css"
      directory "font", "app/assets/stylesheets/font", verbose: false
      template "font-awesome-css/font-awesome.min.css", "app/assets/stylesheets/font-awesome.css", verbose: false
      log :insert, 'FontAwesome stylesheet and fonts'
      copy_file 'bootstrap_overrides.css', 'app/assets/stylesheets/bootstrap_overrides.css'
      inject_into_file "app/assets/stylesheets/application.css",
                        "\n\n/*= require #{bootswatch_name} */\n/*= require bootstrap_overrides */",
                        after: %r{\*\/}
      log :insert, 'Stylesheet manifest directives'
      template 'bootstrap.min.js', 'app/assets/javascripts/bootstrap.min.js'
      inject_into_file 'app/assets/javascripts/application.js',
                       "\n//= require bootstrap.min",
                       after: /^\/\/= require jquery$/,
                       verbose: false
      log :insert, 'Javascript manifest directives'
    end

    def generate_layout
      template "layout.html.erb", "app/views/layouts/#{layout_file}.html.erb" if options[:layout]
    end

  protected

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
      Dir["bootstrap-css/*"].entries
    end
  end
end
