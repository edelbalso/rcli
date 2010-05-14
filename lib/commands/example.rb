class ExampleCommand  < Command
  
  def after_init
    s
    # called after Command::initialize
    @description = "An example command that lists directories in a current folder"
    f
  end

  def before_main
    s
    # called right before the command's ::main() function
    f
  end
  
  def main
    s
    options = parse_parameters

    $verbose= options.verbose

    @local.load_lib    
    
    if @params[:no_dash_args].size == 0
      @cli_interface.list_local_artists_to_add(@local.artists)
    else
      @params[:no_dash_args].each do |fs_key|
        list_fs_key(fs_key)
      end
    end
    f
  end


end