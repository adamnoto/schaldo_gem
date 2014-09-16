require "rails/generators"

module Schaldo
  module Generators
    class SchaldoGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      namespace "schaldo"

      def make_initializer
        template "initialize_schaldo.rb", "config/initializers/schaldo.rb"
      end
    end
  end
end