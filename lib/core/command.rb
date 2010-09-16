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

  def self.default_cmd; Rcli::APP_CONFIG['global']['default_command']; end

  def run(params = {})
    before_main

    @params = params

    @options = parse_parameters
    $verbose= @options.verbose

    main

    after_main
  end

  def main
    puts "ERROR: main() method not defined for this command. Please define " + self.class.to_s + "#main() to continue."
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
  def self.load_all
    commands = {}
    
    require Rcli::GEM_LIB + DS + 'commands' + DS + 'debug'
    require Rcli::GEM_LIB + DS + 'commands' + DS + 'help'
    commands['debug'] = { :instance => DebugCommand.new }
    commands['help'] = { :instance => HelpCommand.new }
    
    Command.get_allowed_commands.each do |c|
      require Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + c if File.exist?(Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + c + '.rb')
      commands[c] = {
#        :instance => TraceableFactory.createTraceableObject(camelize(c) + "Command")
        :instance => Object.const_get("#{camelize(c)}Command").new
      }
    end
    
    

    commands
  end

  def self.load(command)
    commands = {}

    if Command.get_allowed_commands.include?(command) 
      require Rcli.script_root + '/lib/commands/' + command if File.exist?(Rcli.script_root + '/lib/commands/' + command + '.rb')
      commands[command] = {
#        :instance => TraceableFactory.createTraceableObject("#{camelize(command)}Command")
        :instance => Object.const_get("#{camelize(command)}Command").new
      }
    end

    commands
  end

  def self.get_allowed_commands
    results = Array.new
    
    glob = Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + '*'
    Dir[glob].each{ |c| results << File.basename(c,'.rb')}

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