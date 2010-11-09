### Core Libraries
require 'rubygems'
require 'text'
require 'yaml'
require 'pp'
require 'pathname'
require 'highline/import'

### Globals
$verbose = false # set to true by command line
DS = File::SEPARATOR # / on unix, \ on windows. DS is a shortcut and faster to type


require 'core/shared/rcli_installation.rb'

class Rcli

  include Rcli::Installation

  SRC_PATH = File.expand_path('~/lib/ruby/rcli_framework')
  
  GEM_ROOT = File.dirname(File.dirname(__FILE__))
  GEM_LIB = GEM_ROOT + DS + 'lib'
  GEM_BIN = GEM_ROOT + DS + 'bin'
  GEM_CONFIG = GEM_ROOT + DS + 'lib' + DS + 'config'
  
  RCLI_DOTFOLDER = File.expand_path("~" + DS + '.rcli')
  
  if File.exists? (RCLI_DOTFOLDER + DS + 'config.yml')
    RCLI_CONFIG = YAML.load_file(RCLI_DOTFOLDER + DS + 'config.yml')
  else
    RCLI_CONFIG = YAML.load_file(GEM_LIB + DS + 'config' + DS + 'application.yml')
  end

  @@trace_app = false
  @@script_root = 'uninitialized'
  @@script_config = nil
  @@type = :app
  
  def self.script_root ; @@script_root ; end
  def self.script_root=(sr) ; 
    @@script_root = sr ; 
    if @@type == :app
      @@script_config = YAML.load_file(sr + DS + 'config' + DS + 'application.yml')
    else
      @@script_config = RCLI_CONFIG
    end
  end
  def self.script_config ; @@script_config ; end
  def self.script_config=(sc) ; @@script_config = sc ; end
  def self.trace_app ; @@trace_app ; end
  def self.trace_app=(ta) ; @@trace_app = ta ; end
  def self.type ; @@type ; end
  def self.type=(t) ; @@type = t ; end
  
  def self.go ; Commander.new.go ; end
end


### Application Libraries
require 'core/traceable_factory'
require 'core/actions'
require 'core/global_functions'
require 'vendor/trollop'
require 'core/commander'
