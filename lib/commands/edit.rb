class EditCommand < Command
  
  def after_init
    @description = "Opens a script for editing in your editor of choice"
  end
  
  def main
      if @params[:args].size != 1
        puts "ERROR: please provide a rcli app name to look up. Try 'rcli list' for a list of installed apps."
      end

      name = @params[:args][0]

      if name == 'core'
        exec "mate #{Rcli::SRC_PATH}"
        exit
      end
      
      yml_file = Rcli::RCLI_DOTFOLDER + DS + 'app_info' + DS + @params[:args][0] + '.yml'
      unless File.exists? yml_file
        puts "ERROR: That app is not installed"
        exit
      end
      
      app_info = YAML.load_file(yml_file)
      
      unless File.directory? app_info['application_root']
        puts "ERROR: The installed application's folder could not be found"
        exit
      end

      exec "mate #{app_info['application_root']}"
    end

end