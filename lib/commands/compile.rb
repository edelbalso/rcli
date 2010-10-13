class CompileCommand < Command
  
  description 'Uninstalls and reinstalls rcli gem to your system from source. YMMV'
  usage 'rcli compile'
  
  def main
    
    FileUtils.cd(Rcli::SRC_PATH)
    `./comp`
    
    puts "Done"
    # exec 'comp'
  end
  
end