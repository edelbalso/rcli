class ExampleCommand  < Command
  
  def after_init
    # called after Command::initialize
    @description = "An example command that lists directories in a current folder"
  end

  def before_main
    # called right before the command's ::main() function
  end
  
  def main
    # @local.load_lib    
    # 
    # if @params[:no_dash_args].size == 0
    #   @cli_interface.list_local_artists_to_add(@local.artists)
    # else
    #   @params[:no_dash_args].each do |fs_key|
    #     list_fs_key(fs_key)
    #   end
    # end
  end


end
