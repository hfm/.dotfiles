require 'rubygems'
#require 'awesome_print'
require 'pry-theme'


Pry.config.theme = "monokai"

# begin
#   Pry.print = proc { |output, value| output.puts value.ai }
# rescue
#   puts "=> Unable to load awesome_print, please type 'gem install awesome_print' or 'sudo gem install awesome_print'."
# end

Pry.config.prompt = proc do |obj, level, _|
  prompt = "\e[0;33m"
  prompt << "#{Rails.version} @ " if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> \e[0m"
end
