require 'optparse'
require 'ostruct'

class Command

  attr_reader :description

  def initialize
    before_init
    @description = "Current action not described. Please override " + self.class.to_s + "::@description in after_init."
    @params = {}
    @options = nil
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

    @options = parse_parameters
    $verbose= @options.verbose

    main

    after_main
  end

  def main
    puts "ERROR: main() method not defined for this command. Please define " + self.class.to_s + "::main() to continue."
  end

  def help
    ARGV.push('-h')
    opts = parse_parameters
  end
  
  #should be over-ridden in Command classes.
  def before_main; end
  def after_main; end

  def before_init; end
  def after_init; end


  #### CLASS METHODS #####
  def self.load_all(path)
    commands = {}

    ccm('Command','get_allowed_commands').each do |c|
      
      require path + '/lib/commands/' + c if File.exist?(path + '/lib/commands/' + c + '.rb')
      commands[c] = {
        :instance => TraceableFactory.createTraceableObject(camelize(c) + "Command")
      }
    end

    commands
  end

  def self.load(command,path)
    commands = {}

    if Command.get_allowed_commands.include?(command) 
      require path + '/lib/commands/' + command if File.exist?(path + '/lib/commands/' + command + '.rb')
      commands[command] = {
        :instance => TraceableFactory.createTraceableObject("#{camelize(command)}Command")
      }
    end

    commands
  end

  def self.get_allowed_commands
    results = Array.new
    Dir[path + '/lib/commands/*'].each{ |c| results << File.basename(c,'.rb')}

    results
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