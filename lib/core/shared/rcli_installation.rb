class Rcli
  module Installation
  
    def _installed_rcli_base?
      File.directory? File.expand_path('~/' + Rcli::APP_CONFIG['global']['hidden_dir_name'] )
    end

    def _install_rcli_base
      if _installed_rcli_base?
        return false
      end

      dotpath = File.expand_path('~/' + Rcli::APP_CONFIG['global']['hidden_dir_name'] )
      puts "Installing to : #{dotpath}"
      # exit
      FileUtils.mkdir_p(dotpath + DS + 'bin')
      FileUtils.mkdir_p(dotpath + DS + 'app_info')

      if agree("Add rcli to your path to allow script installations? [yn]", true)
        File.open(File.expand_path('~/.bash_profile'),'a') { |f|
          f << "\n\n# rcli Installer addition on #{Time.now.inspect}. Adding appropriate PATH variables for use with rcli."
          f << "\nexport PATH=#{dotpath}/bin:$PATH"
          f << "\n# Finished adapting your PATH environment variable for use with rcli."
        }
      end
      
      File.open(dotpath + DS + 'config.yml', 'w') { |f|
        f << File.read(Rcli::GEM_CONFIG + DS + 'application.yaml')
      }
      

    end
  end
end