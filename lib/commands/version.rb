class VersionCommand  < Command
  
  description "Shows the current version of the application."
  
  def main
    options = parse

    puts "#{Rcli.script_config['global']['script_name']} version 0.0.1 (alpha)"
  end

end