#!/usr/bin/env ruby

BASEDIR = '/Users/edu/lib/ruby/cliscript'

$LOAD_PATH << BASEDIR

require 'rubygems'
require 'text'

### GLOBALS
$verbose = false # set to true by command line
DS = File::SEPARATOR # / on unix, \ on windows. DS is a shortcut and faster to type

TRACE_APP = false

# require 'lib/core/tracer'


require 'lib/core/commander'


APP_CONFIG = YAML.load_file(BASEDIR + '/config/application.yaml')

# ==========================================================
# This code will only execute if this file is the file
# being run from the command line.
if $0 == __FILE__

  
  commander = Commander.createTraceableObject()
  commander.go

end