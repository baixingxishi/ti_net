require 'rails/generators'

module TiNet
  module Generators
    class InitializerGenerator < Rails::Generators::Base
      desc "Create Notifications's base files"
      source_root File.expand_path('../../../../', __FILE__)

      def add_initializer
        path = "#{Rails.root}/config/initializers/ti_net.rb"
        if File.exist?(path)
          puts 'Skipping config/initializers/ti_net.rb creation, as file already exists!'
        else
          puts 'Adding ti_net initializer (config/initializers/ti_net.rb)...'
          template 'generators/templates/ti_net.rb', path
        end
      end
    end
  end
end
