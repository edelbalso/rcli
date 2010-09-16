class Rcli
  module Installation
  
    def _installed_rcli_base?
      File.directory? File.expand_path('~/' + Rcli::RCLI_CONFIG['global']['hidden_dir_name'] )
    end

  end
end