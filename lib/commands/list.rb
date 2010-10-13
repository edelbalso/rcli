class ListCommand  < Command

  description "Lists all installed rcli programs"
  
  def main()
    
    puts "rcli installed applications"
    puts "---------------------------"
    
    biggest = 0
    Dir[Rcli::RCLI_DOTFOLDER + DS + 'app_info' + DS + '*'].each { |c| biggest = File.basename(c,'.yml').size if biggest < File.basename(c,'.yml').size }

    puts "biggest is #{biggest}" if $verbose
    # commands.sort.each do |name,cmd|
    #   puts "  %-#{biggest}s" % name + "  " + cmd[:instance].description
    # end

    Dir[Rcli::RCLI_DOTFOLDER + DS + 'app_info' + DS + '*'].each { |f|
      puts "loading #{f}..." if $verbose
      app_info = YAML.load_file(f)
      app_config = YAML.load_file(app_info['application_root'] + DS + 'config' + DS + 'application.yml' )
      pp app_info if $verbose
      # puts File.basename(f,'.yml') + " : " + (app_config['global']['description'] || "No description specified in #{File.basename(f,'.yml')}'s application config/application.yml")
      puts "  %-#{biggest}s" % File.basename(f,'.yml') + " : " + (app_config['global']['description'] || "No description specified in #{File.basename(f,'.yml')}'s application config/application.yml")
    }
  end
  
end