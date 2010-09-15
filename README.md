# rcli

## WHAT IS THIS

rcli is a simple tool for writing and managing command-line applications. It
spawned simply from me not liking the idea that I have to type 'thor' before
my command line scripts. This is my take on getting this done a little more
cleanly.

## CAVEAT

This was done a project to learn ruby, and is by no means perfect. If you like 
it, please let me know. If you would like to add features, also let me
know as I'll be glad to hear your ideas and integrate your code.

Most importantly, if you have ideas of things I did wrong and could do better,
let me know! The point is for me to learn, hopefully you find use in this at
the same time.

## INSTALLATION

Find a nice place to put this repo. I like:

	mkdir -p ~/lib/ruby
	cd ~/lib/ruby
	git clone git://github.com/edelbalso/rcli.git

Now build the gem

	cd rcli
	build rcli.gemspec
	gem install rcli-0.6.gem
	
Then install the required gems:

	gem install highline
	gem install text
	
and you should be good to go. Try:

	rcli

If you don't get a page full of exceptions, you're good to go. If so,
get in touch with me and I will help you out.

## ADVANCED INSTAlLATION

*WARNING! WARNING!*

	I suggest you back up your ~/.bash_profile before completing this
	step. You've been warned.

*END WARNING!*

rcli has the capability of 'installing' the applications you make with
it so that they're available system-wide. It does this by creating a
'.rcli' hidden folder and storing the locations of your applications
once they're installed.

To set up this folder in your home directory, type:

	rcli install

It will then prompt you to add a line to your .bash_profile. If you've
succesfully backed up your .bash_profile, go ahead and accept this. The 
uninstall doesn't yet remove the added lines, so if you've done this once,
no point in doing it again or it will just mess up your file unecessarily.

Once installed, do this to load the path into your terminal:

	source ~/.bash_profile

## WRITING YOUR FIRST APP

To get started with rcli, simply create a folder anywhere in your home 
folder where you'd like to keep your applications. I like:

	mkdir -p ~/lib/ruby/rcli_apps/

but any folder will do. Now create your app:

	cd ~/lib/ruby/rcli_apps/
	rcli generate gemate
	rcli install gemate/gemate.rb gemate

You should now have created an application 'gemate' that can be used
from anywhere on your system. Go ahead and confirm this:

	rcli list

'gemate' should be listed here. If you have textmate installed, you
can now go ahead and edit the generate app by typing:

	rcli edit gemate

and you can go ahead and rename the command located at 'lib/commands/example.rb'
to 'lib/commands/view.rb'

	mv gemate/lib/commands/example.rb gemate/lib/commands/view.rb

and put the following code in the file:

	class ViewCommand  < Command
  
	  def after_init
	    # called after Command::initialize
	    @description = "Opens a gem (or gems) to be viewed in Textmate"
	  end

	  def main

	    if @params[:args].size != 1
	      puts "ERROR: please provide a gem name to look up"
	    end
    
	    name = @params[:args][0]
	    term = name + '*'

	    puts "Searching for '" + term + "'..."

	    # get the path to the gem directory from rubygems and search for any matching directories
	    path = `gem env gemdir`
	    new_path = File.join([path.chomp, 'gems'])
	    Dir.chdir(new_path)
	    @d_arr = Dir.glob(term)

	    if @d_arr.empty?
	      puts "Sorry, nothing like that found"
	    elsif @d_arr.size == 1
	      view_one()
	    else
	      view_list()
	    end
    
	  end

	  private

	  def view_one
	    puts @d_arr.first
	    print 'Do you want to view this? [Y/n]: '
	    resp = $stdin.gets.chomp!
	    if resp.empty? or resp.downcase == 'y'
	      exec "mate #{@d_arr.first}"
	    end
	  end

	  def view_list
	    @d_arr.each_with_index {|d,i| puts "#{i + 1}: #{d}"}
	    puts
	    print 'Choose a directory or quit(q): '
	    idx = gets.chomp!
	    if idx.downcase == 'q'
	      exit
	    elsif (1..@d_arr.size).include?(idx.to_i)
	      exec "mate #{@d_arr.at(idx.to_i - 1)}"
	    else
	      puts 'not a valid option'
	    end
	  end

	end

This code has been ripped off from one of the Thor tutorials. My apologies.

Anyways, after saving this file, you should now be able to type

	gemate view thor

and textmate should pop up with the thor. You should similarly be able to 
view any other gem installed on your system.

Congrats, you've made your first command-line app with rcli.


## DEPENDENCIES

sudo gem install highline
sudo gem install text


## ACKNOWLEDGEMENTS

* Yehuda Katz for code I copied from Thor::Actions modules, as well as a bunch of other chunks. :)

## AUTHOR

Eduardo Del Balso