require 'optparse'
require 'ostruct'

class Command

  attr_reader :description

  def initialize
    s
    @description = "Current action not described. Please override " + self.class.to_s + "::@description in after_init."
    @params = {}
    @help_banner = <<-EOS
usage: script.rb example
      Lists all the folders in the current directory

EOS
    after_init
    f
  end

  def self.default_cmd; APP_CONFIG['global']['default_command']; end

  def run(params = {})
    s
    before_main
    @params = params
    main
    f
  end

  def main
    s
    puts "ERROR: main() method not defined for this command. Please define " + self.class.to_s + "::main() to continue."
    f
  end

  def help
    s
    puts "ERROR: help() method not defined. Please override " + self.class.to_s + "::help() to continue"
    f
  end

  def before_main
    s
    #should be over-ridden in Command classes.
    f
  end

  def after_init
    s
    #should be over-ridden in Command classes.
    f
  end


  #### CLASS METHODS #####
  def self.load_all
    s
    commands = {}

    Command.get_allowed_commands.each do |c|
      require 'lib/commands/' + c
      commands[c] = {
        :instance => Object.const_get("#{c.capitalize}Command").new
      }
    end

    f
    commands
  end

  def self.load(command)
    s
    commands = {}

    if Command.get_allowed_commands.include?(command) 
      require 'lib/commands/' + command
      commands[command] = {
        :instance => Object.const_get("#{command.capitalize}Command").new
      }
    end

    f
    commands
  end

  def self.get_allowed_commands
    s
    f
    Dir[BASEDIR + '/lib/commands/*'].collect{ |c| File.basename(c,'.rb')}
  end

private

  def parse_parameters
    # This works with the global ARGV, so no parameters need to be passed.
    opts = Trollop::options do
      banner = @help_banner
      opt :verbose, "Run with extra debugging output", :default => false
      opt :contentsize, "Shows the size of each folder's contents."
    end


  end

end