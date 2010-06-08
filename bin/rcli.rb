#!/usr/bin/env ruby

BASEDIR = '/Users/edu/lib/ruby/cliscript'

$LOAD_PATH << BASEDIR


### Core Libraries
require 'rubygems'
require 'text'
require 'pp'


### GLOBALS
$verbose = false # set to true by command line
TRACE_APP = false


### GLOBAL SHORTCUTS
DS = File::SEPARATOR # / on unix, \ on windows. DS is a shortcut and faster to type

# shortcut to call a class method that you would like to be traceable
def ccm(className, sym, *args, &block)
  TraceableObject.call_class_method(className, sym, *args, &block)
end
# shortcut to instantiate a traceable object
def cto(className)
  TraceableFactory.createTraceableObject(className)
end


### Application Libraries
# require 'lib/core/tracer'
require 'lib/core/traceable_factory'
require 'lib/core/commander'


APP_CONFIG = YAML.load_file(BASEDIR + '/config/application.yaml')


# ==========================================================
# This code will only execute if this file is the file
# being run from the command line.
if $0 == __FILE__

  commander = TraceableFactory.createTraceableObject('Commander')
  commander.go

end