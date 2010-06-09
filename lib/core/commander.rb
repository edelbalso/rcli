require 'core/command'
require 'core/cli_interface'

class Commander

  def initialize
    @commands = Command.load_all
    @cli_interface = CliInterface.new
  end

  def go
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
      puts "ERROR: Please specify a command as first argument"
      exit
    end

    command = ARGV.shift # first parameter should be the command at this point.

    unless @commands.keys.include?(command)
      puts "ERROR: Invalid command: "  + command + ". Please use 'help' command for a list of allowed commands."
      exit
    end

    # Separate arguments into those preceded by dashes (usually options or flags)
    # and those not preceded by dashes (usually files)
    opts = ARGV.collect { |arg| arg if arg[0,1] == '-' }.compact
    args = ARGV.collect { |arg| arg if arg[0,1] != '-'}.compact

    @commands[command][:instance].run(:opts => opts,:args =>args)
    
  end

end