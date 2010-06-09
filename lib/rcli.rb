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
require 'core/traceable_factory'
require 'core/commander'
require 'core/global_functions'
require 'vendor/trollop'

class Rcli

  GEM_ROOT = File.dirname(File.dirname(__FILE__))
  GEM_LIB = GEM_ROOT + DS + 'lib'
  GEM_BIN = GEM_ROOT + DS + 'bin'
  GEM_CONFIG = GEM_ROOT + DS + 'bin' + DS + 'config'
  
  APP_CONFIG = YAML.load_file(GEM_LIB + '/config/application.yaml')
  
  @@trace_app = false
  @@script_root = 'uninitialized'

  def self.script_root ; @@script_root ; end
  def self.script_root=(sr) ; @@script_root = sr ; end
  def self.trace_app ; @@trace_app ; end
  def self.trace_app=(ta) ; @@trace_app = ta ; end
end

# puts Rcli::GEM_ROOT
# puts Rcli::GEM_LIB
# puts Rcli::GEM_BIN
# puts Rcli::GEM_CONFIG
# puts Rcli.script_root
# puts Rcli.trace_app.inspect
# pp Rcli::APP_CONFIG 
# exit