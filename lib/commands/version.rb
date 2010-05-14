class VersionCommand  < Command
  
  def after_init
    @description = "Shows the current version of the application."
  end
  
  def main
    puts "script version 0.1-alpha"
  end

  def help
    s
    ARGV.push('-h')
    opts = parse
    f
  end
end