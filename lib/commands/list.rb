class ListCommand  < Command
  
  def after_init
    @description = "Lists all installed rcli programs"
  end
  
  def main()
    
    puts "rcli installed applications"
    puts "---------------------------"
    
    Dir[Rcli::APP_DOTFOLDER + DS + 'app_info' + DS + '*'].each { |f|
      app = YAML.load_file(f)
      puts File.basename(app['executable'],'.rb') + " : description"
      }
  end
  
end