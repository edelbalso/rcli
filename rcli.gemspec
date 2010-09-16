Gem::Specification.new do |s|
  s.name = 'rcli'
  s.version = '0.6'
  s.summary = %{A rough framework for building command-line scripts in ruby.}
  s.date = %q{2010-06-08}
  s.author = "Eduardo Del Balso"
  s.email = "e.delbalso@gmail.com"
  s.homepage = "http://github.com/edelbalso/rcli"

  s.files = ["lib/commands/compile.rb", "lib/commands/debug.rb", "lib/commands/edit.rb", "lib/commands/generate.rb", "lib/commands/help.rb", "lib/commands/install.rb", "lib/commands/list.rb", "lib/commands/uninstall.rb", "lib/commands/version.rb", "lib/config/application.yml", "lib/core/actions/create_file.rb", "lib/core/actions/empty_directory.rb", "lib/core/actions/file_binary_read.rb", "lib/core/actions.rb", "lib/core/command.rb", "lib/core/commander.rb", "lib/core/console.rb", "lib/core/global_functions.rb", "lib/core/shared/rcli_installation.rb", "lib/core/thor_actions/create_file.rb", "lib/core/thor_actions/directory.rb", "lib/core/thor_actions/empty_directory.rb", "lib/core/thor_actions/file_binary_read.rb", "lib/core/thor_actions/file_manipulation.rb", "lib/core/thor_actions/inject_into_file.rb", "lib/core/thor_actions.rb", "lib/core/traceable_factory.rb", "lib/core/traceable_object.rb", "lib/core/tracer.rb", "lib/rcli.rb", "lib/templates/new_app/config/application.yml", "lib/templates/new_app/lib/commands/default.rb", "lib/templates/new_app/lib/commands/version.rb", "lib/templates/new_app/RCLIAPPNAME.rb", "lib/vendor/trollop.rb", "README.md"]
  s.executables = ['rcli']
  s.require_paths = ['lib']

end