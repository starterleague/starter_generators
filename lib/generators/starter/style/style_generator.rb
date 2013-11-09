module Starter
  class StyleGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :theme_name, :type => :string#, :default => 'default'

    class_option :layout, :type => :boolean, :default => true, :desc => "Generate a new application layout."
    class_option :navbar, :type => :boolean, :default => true, :desc => "Generate a model-based navbar."
    argument :layout_file, :type => :string, :default => 'application', :desc => "Layout filename"

    def generate_layout
      if bootswatch_theme?
        log :insert, "Bootswatch theme '#{theme_name}'"
      else
        log :insert, 'Bootstrap CSS framework'
      end
      log :insert, 'FontAwesome support'
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

  end
end
