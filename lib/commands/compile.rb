class CompileCommand < Command
  
  def before_init
    @description = 'Uninstalls and reinstalls rcli to your system from source. YMMV'
  end
  
  def main
    
    FileUtils.cd(Rcli::SRC_PATH)
    `./comp`
    
    puts "Done"
    # exec 'comp'
  end
end