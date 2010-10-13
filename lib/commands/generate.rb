class GenerateCommand  < Command
  
  include Rcli::Actions

  description "Generates a template CLI script in current folder"

  def main()
        
    if @params[:args].length != 1
      puts "ERROR: You must provide a unique app name as an argument."
      exit
    end

    if File.directory? Dir.pwd + DS + @params[:args][0]
      puts "ERROR: folder already exists. Please choose another name"
      exit
    end
        
    app_name = @params[:args][0]
    
    tpl_dir = Rcli::GEM_LIB + DS + 'templates' + DS + 'new_app'
        
    # iterate through the new_app template
    Dir[ tpl_dir + DS + '**' + DS + '*.*'].each do |f|
      # TODO : Use Pathname#relative_path_from for this.
      new_file_name = f[tpl_dir.length + 1 ,f.length - tpl_dir.length]
      
      new_file_name.gsub!(/RCLIAPPNAME/,app_name)

      puts "creating " + app_name + DS + new_file_name
      create_file Dir.pwd() + DS + app_name + DS + new_file_name do
        contents = File.read(f)
        contents.gsub(/RCLIAPPNAME/,app_name)
      end
      
      if f == tpl_dir + DS + 'RCLIAPPNAME.rb'
        puts "Changing executable mode of " + new_file_name
        File.chmod(0755,Dir.pwd() + DS + app_name + DS + new_file_name)
      end
    end
  end

end