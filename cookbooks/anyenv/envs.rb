include_recipe './default.rb'
include_recipe './definitions.rb'

package 'erlang'

%w(
  plenv
  rbenv
).each { |env| anyenv_install env }

directory "#{Dir.home}/.anyenv/envs/rbenv/plugins"

git "#{Dir.home}/.anyenv/envs/rbenv/plugins/rbenv-default-gems" do
  repository "https://github.com/sstephenson/rbenv-default-gems"
end

git "#{Dir.home}/.anyenv/envs/rbenv/plugins/rbenv-each" do
  repository "https://github.com/rbenv/rbenv-each"
end

remote_file "#{Dir.home}/.anyenv/envs/rbenv/default-gems"
remote_file "#{Dir.home}/.gemrc"
remote_file "#{Dir.home}/.irbrc"
remote_file "#{Dir.home}/.pryrc"
