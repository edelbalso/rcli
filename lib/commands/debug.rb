class DebugCommand  < Command
  
  def after_init
    # called after Command::initialize
    @description = "Dumps debug variables"
  end

  def before_main
    # called right before the command's ::main() function
  end
  
  def main
  
    print "Dir.pwd                : " 
    puts Dir.pwd
    print "Rcli::GEM_ROOT         : "
    puts Rcli::GEM_ROOT
    print "Rcli::GEM_LIB          : "
    puts Rcli::GEM_LIB
    print "Rcli::GEM_BIN          : "
    puts Rcli::GEM_BIN
    print "Rcli::GEM_CONFIG       : "
    puts Rcli::GEM_CONFIG
    print "Rcli.script_root       : "
    puts Rcli.script_root
    print "Rcli.trace_app.inspect : "
    puts Rcli.trace_app.inspect
    print "Rcli::APP_DOTFOLDER          : "
    puts Rcli::APP_DOTFOLDER
    puts "\nRcli::APP_CONFIG :"
    pp Rcli::APP_CONFIG 
  end


end