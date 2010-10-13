class DebugCommand  < Command
  
  description "Dumps debug variables"
  usage "rcli debug [console]"

  def main
    allowed_commands = ['console']
    if @params[:args].size == 0
      default_debug
    elsif @params[:args].size == 1 && allowed_commands.include?( @params[:args][0] )
      send( "console_debug" )
    else
      puts "ERROR: Invalid command"
    end
  end

private

  def console_debug
    # Supported color sequences.
    colors = %w{black red green yellow blue magenta cyan white}

    # Using color() with symbols.
    colors.each_with_index do |c, i|
      say("This should be <%= color('#{c}', :#{c}) %>!")
      if i == 0
        say( "This should be " +
             "<%= color('white on #{c}', :white, :on_#{c}) %>!")
      else
        say( "This should be " +
             "<%= color( '#{colors[i - 1]} on #{c}',
                         :#{colors[i - 1]}, :on_#{c} ) %>!")
      end
    end

    # Using color with constants.
    say("This should be <%= color('bold', BOLD) %>!")
    say("This should be <%= color('underlined', UNDERLINE) %>!")

    # Using constants only.
    say("This might even <%= BLINK %>blink<%= CLEAR %>!")

    # It even works with list wrapping.
    erb_digits = %w{Zero One Two Three Four}      +
                 ["<%= color('Five', :blue) %%>"] +
                 %w{Six Seven Eight Nine}
    say("<%= list(#{erb_digits.inspect}, :columns_down, 3) %>")

  end
  def default_debug
    puts " misc"
    puts " ----"
    print "Dir.pwd : " 
    puts Dir.pwd
    puts
    
    puts  " rcli"
    puts  " ----"
    print "Rcli::GEM_ROOT       : "
    puts Rcli::GEM_ROOT
    print "Rcli::GEM_LIB        : "
    puts Rcli::GEM_LIB
    print "Rcli::GEM_BIN        : "
    puts Rcli::GEM_BIN
    print "Rcli::GEM_CONFIG     : "
    puts Rcli::GEM_CONFIG
    print "Rcli::RCLI_DOTFOLDER : "
    puts Rcli::RCLI_DOTFOLDER
    puts  "Rcli::RCLI_CONFIG    :"
    pp Rcli::RCLI_CONFIG 
    puts
    
    puts  " script"
    puts  " ------"
    print "Rcli.type          : "
    puts Rcli.type
    print "Rcli.script_root   : "
    puts Rcli.script_root
    print "Rcli.trace_app     : "
    puts Rcli.trace_app
    puts  "Rcli.script_config :"
    pp Rcli.script_config

    
  end
end