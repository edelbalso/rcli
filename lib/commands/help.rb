class HelpCommand  < Command
  
  def after_init
    @description = "Shows the current help screen"
  end

  def main
    
    if Rcli.script_config['global']['mode'] == 'single'
      puts @usage
      puts
      puts "descr: " + Rcli.script_config['global']['description']
      puts
      puts "Options:"
      puts " -h, --help   shows the current help screen"
      puts " --version    shows the application version"
      puts " -v           enables verbose output"
    else
      if @params[:args].size == 0
        puts @help_banner
    
        commands = Command.load_all
     
        puts "Commands currently implemented are:"
    
        # calculate column width
        biggest = 0
        commands.each { |c,data| biggest = c.size if biggest < c.size }

        commands.sort.each do |name,cmd|
          puts "  %-#{biggest}s" % name + "  " + cmd[:instance].description
        end
    
        puts 
        puts "Type '#{Rcli.script_config['global']['script_name']} help COMMAND' for instructions on using a specific command"
      else
        Command.load(@params[:no_dash_args][0])
      
        cmd[@params[:no_dash_args][0]][:instance].help
      end
    end
  end
end