class InitCommand < Command
  
  def after_init
    @description = 'Sets up the current folder to act as an mp3 repository.'
  end
  
  def main
    repo_key = ask("Please enter your repo key: ") do |q| 
      q.validate = /^[a-zA-Z0-9]{32}$/ 
      q.responses[:not_valid] = "That repo key is invalid"
      q.responses[:ask_on_error] = :question
    end
    
    puts "Thank you. Validating " + repo_key + ", please wait..." if $verbose
    result = RepoApi.get(repo_key,'validate_repo')
    
    if result['status'] == 'SUCCESS'
      puts "repo key is valid!" if $verbose
      @local.init_repo(repo_key)
      @local.load_lib
      
      puts "Initialized empty mp3repo in " + @local.dir + @local.hdn
    else
      puts "ERROR: That repo key is invalid"
    end
    
    
  end

end