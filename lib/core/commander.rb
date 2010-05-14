require 'lib/core/traceable_object'
require 'lib/core/command'
require 'lib/core/cli_interface'

class Commander

  def self.CreateTraceableObject
    obj = Commander.new
    if APP_TRACE
      return TraceableObject.new(obj)
    else
      return obj
    end
  end
  
  def initialize
    s
    @commands = Command.load_all
    @cli_interface = CliInterface.new
    f
  end

  def go
    s
    if ARGV.size == 0
      ARGV.push Command.default_cmd # default action
    end

    if ARGV.first == '--version'
      ARGV[0] = 'version' # simulate 'script --version' functionality
    end

    if ARGV.first == '-h' || ARGV.first == '--help'
      ARGV[0] = 'help' # catch help requests.
    end

    if ARGV.first[0,1] !~ /^[a-zA-z]$/ 
      puts "ERROR: Please specify a command"
      exit
    end

    command = ARGV.shift # first parameter should be the command at this point.

    unless @commands.keys.include?(command)
      puts "ERROR: Invalid command: "  + command + ". Please use 'help' command for a list of allowed commands."
      exit
    end

    # Separate arguments into those preceded by dashes (usually options or flags)
    # and those not preceded by dashes (usually files)
    args = ARGV.collect { |arg| arg if arg[0,1] == '-' }.compact
    no_dash_args = ARGV.collect { |arg| arg if arg[0,1] != '-'}.compact

    @commands[command][:instance].run(:args => args,:no_dash_args =>no_dash_args)
    
    f
  end

end