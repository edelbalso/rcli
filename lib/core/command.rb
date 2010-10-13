class Command

  attr_reader :description

  class << self
    def description(d); @description = d; end
    def usage(u); @usage = u; end
    def describe; @description; end
    def show_use; @usage; end
  end
  
  def initialize
    before_init
    @params = {}
    @options = nil

    # if Rcli.script_config['global']['mode'] == 'multi'
    #   @@description = "Current action not described. Please use \"description '...'\" in " + self.class.to_s + " to correct."
    #   @@usage = "Usage:\n       #{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 "
    # else
    #   @@description = Rcli.script_config['global']['description'] 
    #   @@usage = "Usage:\n       #{Rcli.script_config['global']['script_name']} [--flags,-f] arg1 arg2 arg3 "
    # end

    after_init
  end
  
  def self.default_cmd; Rcli.script_config['global']['default_command']; end

  def run(params = {})
    @params = params
    @options = parse_parameters
    $verbose= @options.verbose
    main
  end

  def main
    puts "ERROR: main() method not defined for this command. Please define " + self.class.to_s + "#main() to continue."
  end

  def help
    ARGV.push('-h')
    opts = parse_parameters
    puts
  end
  
  #should be over-ridden in Command classes.
  def before_init; end
  def after_init; end


  #### CLASS METHODS #####
  def self.load_all
    commands = {}
    
    require Rcli::GEM_LIB + DS + 'commands' + DS + 'debug'
    require Rcli::GEM_LIB + DS + 'commands' + DS + 'help'
    commands['debug'] = { :instance => DebugCommand.new }
    commands['help'] = { :instance => HelpCommand.new }
    HelpCommand.description "Current action not described. Please use \"description '...'\" in HelpCommand to correct." if not HelpCommand.describe
    HelpCommand.usage "#{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 " if not HelpCommand.show_use
    DebugCommand.description "Current action not described. Please use \"description '...'\" in DebugCommand to correct." if not DebugCommand.describe
    DebugCommand.usage "#{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 " if not DebugCommand.show_use
    

    Command.get_allowed_commands.each do |c|
      require Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + c if File.exist?(Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + c + '.rb')
      Object.const_get("#{camelize(c)}Command").description "Current action not described. Please use \"description '...'\" in #{camelize(c)}Command to correct." if not Object.const_get("#{camelize(c)}Command").describe
      Object.const_get("#{camelize(c)}Command").usage "#{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 " if not Object.const_get("#{camelize(c)}Command").show_use
      # usage "#{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 "
      
      if c != 'debug' && c != 'help'
        commands[c] = {
#          :instance => TraceableFactory.createTraceableObject(camelize(c) + "Command")
          :instance => Object.const_get("#{camelize(c)}Command").new
        }
      end
    end

    commands
  end

  def self.load(command)
    commands = {}

    if Command.get_allowed_commands.include?(command) 
      require Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + command if File.exist?(Rcli.script_root + DS + 'lib' + DS + 'commands' + DS  + command + '.rb')
      Object.const_get("#{camelize(command)}Command").description "Current action not described. Please use \"description '...'\" in #{camelize(command)}Command to correct." if not Object.const_get("#{camelize(command)}Command").describe
      Object.const_get("#{camelize(command)}Command").usage "#{Rcli.script_config['global']['script_name']} <command> [--flags,-f] arg1 arg2 arg3 " if not Object.const_get("#{camelize(command)}Command").show_use
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

  # def parse_parameters
  #   # This works with the global ARGV, so no parameters need to be passed.
  #   begin
  #     opts = Trollop::options do
  #       banner @@description
  #       banner @@usage
  #       opt :verbose, "Run with extra debugging output", :default => false
  #     end
  #   rescue Trollop::HelpNeeded
  #     exit # stop if help is being displayed
  #   end
  # 
  # end

  def parse_parameters
    refclass = self.class
    # This works with the global ARGV, so no parameters need to be passed.
    opts = Trollop::options do
      banner "\n" + refclass.describe
      banner "\nusage: \n       " + refclass.show_use + "\n"
      banner "\noptions:"
      opt :verbose, "Run with extra debugging output", :default => false
      
      banner "\n"
    end
  end

end