require "highline/import"
require 'core/shared/rcli_installation'
class InstallCommand  < Command
  
  include Rcli::Installation
  
  def after_init
    @description = "Installs rcli to your system, or installs a specific rcli app"
  end
  
  def main()
    
    if $verbose
      print "params : "
      pp @params
    end
      
    if _installed_rcli_base? && @params[:args].length > 0
      if @params[:args].length != 2
        puts "ERROR: Incorrect syntax. Please use 'rcli install [script] [alias]'"
        exit
      end
      unless File.exists? @params[:args][0]
        puts "ERROR: The filename provided does not exist. Please type 'rcli install help' for proper usage."
      end
      unless File.executable_real? @params[:args][0]
        puts "ERROR: The script you're trying to install is not executable. Please type 'rcli install help' for proper usage."
      end
      if File.exists? Rcli::APP_DOTFOLDER + DS + 'bin' + DS + @params[:args][1]
        puts "ERROR: The install name for that script is already taken"
        exit
      end
            
      unless FileUtils.ln_s(File.expand_path(@params[:args][0]),Rcli::APP_DOTFOLDER + DS + 'bin' + DS + @params[:args][1])
        puts "ERROR: There was a problem installing " + @params[:args][1]
        exit
      end
      
      unless File.open(File.expand_path(Rcli::APP_DOTFOLDER + DS + 'app_info' + DS + @params[:args][1] + '.yml'),'w') { |f|
          f << 'application_root: ' + File.dirname(File.expand_path(@params[:args][0])) + "\n"
          f << 'executable: ' + File.basename(File.expand_path(@params[:args][0]))
        }
        puts "ERROR: There was a problem installing " + @params[:args][1]
        FileUtils.rm(File.expand_path(@params[:args][0]),Rcli::APP_DOTFOLDER + DS + 'bin' + DS + @params[:args][1])
        exit
      end
        
    elsif @params[:args].length > 0 && !_installed_rcli_base?
      puts "You haven't installed the rcli base yet. Please run 'rcli install' first."
    elsif _installed_rcli_base?
      puts "rcli base already installed"
    else
      if _install_rcli_base
        puts "rcli successfully installed"
      else
        puts "ERROR"
      end
    end
  end
end