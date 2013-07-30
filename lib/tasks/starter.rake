namespace :starter do

  desc "Sync the code"
  task :sync => :environment do
    puts "Wazzzzzup!"
    puts ActiveRecord::Base.subclasses.inspect
  end

end
