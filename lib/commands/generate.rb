class GenerateCommand  < Command
  
  def after_init
    @description = "Generates a template CLI script in current folder"
  end
  
  def main()
    
    puts Dir.pwd
  end
end