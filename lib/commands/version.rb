class VersionCommand  < Command
  
  def after_init
    @description = "Shows the current version of the application."
  end
  
  def main
    options = parse

    puts "script version 0.1-alpha"
  end

  def help
    ARGV.push('-h')
    opts = parse
  end

  private
    def parse
      # This works with the global ARGV, so no parameters passed.
      begin
        opts = Trollop::options do
        banner <<-EOS
usage: script.rb version [-v]
 
EOS
  
          opt :verbose, "Run with extra debugging output", :default => false
        end
      rescue Trollop::HelpNeeded
        exit # stop if help is being displayed
      end

      $verbose = opts.verbose

      opts
    end
end