require 'fileutils'
require 'uri'
require 'core/actions/file_binary_read'

glob = Rcli::GEM_LIB  + DS + 'core' + DS + 'actions' + DS + '*'
Dir[glob].each do |action|
  puts "requiring action : " + action if $verbose
  require action
end