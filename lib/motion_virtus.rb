unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'motion_descendants_tracker'
require 'motion_coercible'

require 'motion-require'
Motion::Require.all(Dir.glob(File.expand_path('../project/**/*.rb', __FILE__)))

Motion::Project::App.setup do |app|
  #configuration
end
