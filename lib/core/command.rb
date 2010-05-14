require 'optparse'
require 'ostruct'

class Command

  attr_reader :description

  def initialize
    @description = "Current action not described. Please override " + self.class.to_s + "::@description in after_init."
    @params = {}
    @help_banner = <<EOS
usage: script.rb example
      Lists all the folders in the current directory

EOS
    after_init
  end

  def self.default_cmd; APP_CONFIG['global']['default_command']; end

  def run(params = {})
    before_main
    @params = params
    main
  end

  def main
    puts "ERROR: main() method not defined for this command. Please define " + self.class.to_s + "::main() to continue."
  end

  # def help
  #   puts "ERROR: help() method not defined. Please override " + self.class.to_s + "::help() to continue"
  # end
  # 

  def help
    ARGV.push('-h')
    opts = parse_parameters
  end
  
  def before_main
    #should be over-ridden in Command classes.
  end

  def after_init
    #should be over-ridden in Command classes.
  end


  #### CLASS METHODS #####
  def self.load_all
    commands = {}

    ccm('Command','get_allowed_commands').each do |c|
      require 'lib/commands/' + c
      commands[c] = {
        :instance => TraceableFactory.createTraceableObject("#{c.capitalize}Command")
      }
    end

    commands
  end

  def self.load(command)
    commands = {}

    if Command.get_allowed_commands.include?(command) 
      require 'lib/commands/' + command
      commands[command] = {
        :instance => TraceableFactory.createTraceableObject("#{command.capitalize}Command")
      }
    end

    commands
  end

  def self.get_allowed_commands
    Dir[BASEDIR + '/lib/commands/*'].collect{ |c| File.basename(c,'.rb')}
  end

private

  def parse_parameters
    # This works with the global ARGV, so no parameters need to be passed.
    begin
      opts = Trollop::options do
        banner @help_banner
        opt :verbose, "Run with extra debugging output", :default => false
      end
    rescue Trollop::HelpNeeded
      exit # stop if help is being displayed
    end

  end

end