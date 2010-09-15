### Core Libraries
require 'rubygems'
require 'text'
require 'YAML'
require 'pp'
require 'pathname'
require 'core/shared/rcli_installation.rb'

### Globals
$verbose = false # set to true by command line
DS = File::SEPARATOR # / on unix, \ on windows. DS is a shortcut and faster to type

class Rcli

  include Rcli::Installation
  
  GEM_ROOT = File.dirname(File.dirname(__FILE__))
  GEM_LIB = GEM_ROOT + DS + 'lib'
  GEM_BIN = GEM_ROOT + DS + 'bin'
  GEM_CONFIG = GEM_ROOT + DS + 'lib' + DS + 'config'
  
  SRC_PATH = File.expand_path('~/lib/ruby/rcli_framework')
  APP_DOTFOLDER = File.expand_path("~" + DS + '.rcli')
  
  if File.exists? (APP_DOTFOLDER + DS + 'config.yml')
    APP_CONFIG = YAML.load_file(APP_DOTFOLDER + DS + 'config.yml')
  else
    APP_CONFIG = YAML.load_file(GEM_LIB + '/config/application.yaml')
  end

  
  @@trace_app = false
  @@script_root = 'uninitialized'

  def self.script_root ; @@script_root ; end
  def self.script_root=(sr) ; @@script_root = sr ; end
  def self.trace_app ; @@trace_app ; end
  def self.trace_app=(ta) ; @@trace_app = ta ; end
end


### Application Libraries
require 'core/traceable_factory'
require 'core/actions'
require 'core/global_functions'
require 'vendor/trollop'
require 'core/commander'
