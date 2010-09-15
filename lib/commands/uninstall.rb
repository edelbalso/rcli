require "highline/import"

class UninstallCommand  < Command
  
  include Rcli::Installation
  
  def after_init
    @description = "Uninstalls rcli from your system, or uninstalls a specific rcli app"
  end
  
  def main()
    
    if $verbose
      print "params : "
      pp @params
    end
      
    if _installed_rcli_base? && @params[:args].length > 0
      unless !File.exists? Rcli::APP_DOTFOLDER + DS + 'bin' + DS + @params[:args][0]
        puts "ERROR: The rcli app you provided does not exist. Please type 'rcli list' for list of installed apps."
      end

      FileUtils.rm(File.exists? Rcli::APP_DOTFOLDER + DS + 'bin' + DS + @params[:args][0])
      FileUtils.rm(File.exists? Rcli::APP_DOTFOLDER + DS + 'app_info' + DS + @params[:args][0] + '.yml')

    elsif @params[:args].length > 0 && !_installed_rcli_base?
      puts "You haven't installed the rcli base yet. Please run 'rcli install' first."
    elsif _installed_rcli_base?
      if agree('Are you sure you want to completely remove rcli from your system? (y/n)', true)
        puts "Deleting : " + Rcli::APP_DOTFOLDER if $verbose
        FileUtils.rm_rf(Rcli::APP_DOTFOLDER)
      end
    else
      puts "ERROR: rcli isn't installed"
    end
  end
  
end