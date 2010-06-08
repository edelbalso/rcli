#!/usr/bin/env ruby


require 'pathname'
RCLI_PATH = '/Users/edu/lib/ruby/cliscript'
tmp = File.dirname(Pathname.new(__FILE__).realpath)
tmp = tmp.split(File::SEPARATOR)
tmp.pop
SCRIPT_PATH = tmp.join(File::SEPARATOR)

$LOAD_PATH << RCLI_PATH

# If we're in a generated script, want to load both commands
if SCRIPT_PATH != RCLI_PATH
  $LOAD_PATH << SCRIPT_PATH
end


### Core Libraries
require 'rubygems'
require 'text'
require 'YAML'
require 'pp'

### GLOBALS
$verbose = false # set to true by command line
TRACE_APP = false

require 'lib/core/global_functions'

### Application Libraries
# require 'lib/core/tracer'
require 'lib/core/traceable_factory'
require 'lib/core/commander'

APP_CONFIG = YAML.load_file(RCLI_PATH + '/config/application.yaml')


# ==========================================================
# This code will only execute if this file is the file
# being run from the command line.
if $0 == __FILE__

  commander = TraceableFactory.createTraceableObject('Commander')
  commander.go

end