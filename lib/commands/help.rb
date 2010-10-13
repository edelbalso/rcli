class HelpCommand  < Command

  # description "Shows the current help screen"
  # usage "rcli help <command>"
  
  def main
    
    if Rcli.script_config['global']['mode'] == 'single'
      cmdname = Rcli.script_config['global']['default_command']
      cmd = Command.load(cmdname)
      cmd[cmdname][:instance].help
    else
      if @params[:args].size == 0
        puts
        puts Rcli.script_config['global']['description']
        puts
        puts "usage:\n     " + self.class.show_use
        puts
        
        commands = Command.load_all

        # require Rcli.script_root + DS + 'lib' + DS + 'commands' + DS + 'help'
        # pp ::HelpCommand.describe ; exit

        puts "Commands currently implemented are:"
    
        # calculate column width
        biggest = 0
        commands.each { |c,data| biggest = c.size if biggest < c.size }

        commands.sort.each do |name,cmd|
          next if name == 'help'
          # puts "#{name}, :: #{cmd}"
          puts "  %-#{biggest}s" % name + "  " + cmd[:instance].class.describe if name != 'debug'
        end
    
        puts 
        puts "Type '#{Rcli.script_config['global']['script_name']} help COMMAND' for instructions on using a specific command"
        puts 
      else
        cmd = Command.load(@params[:args][0])
      
        cmd[@params[:args][0]][:instance].help
      end
    end
  end
end