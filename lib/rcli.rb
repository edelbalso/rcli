### Core Libraries
require 'rubygems'
require 'text'
require 'YAML'
require 'pp'
require 'pathname'

### Globals
$verbose = false # set to true by command line
DS = File::SEPARATOR # / on unix, \ on windows. DS is a shortcut and faster to type

### Application Libraries
require 'lib/core/traceable_factory'
require 'lib/core/commander'
require 'lib/core/global_functions'

module Rcli
  GEM_ROOT = File.dirname(File.dirname(__FILE__))
  GEM_LIB = GEM_ROOT + DS + 'lib'
  GEM_BIN = GEM_ROOT + DS + 'bin'
  
  TRACE_APP = false

end

