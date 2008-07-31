GEM_DIR = File.dirname(__FILE__) + "/pkg"

desc "Build the gitnotify gem"
task :gem do
  gemspec = File.dirname(__FILE__) + "/gitnotify.gemspec"
  `gem build #{gemspec}`
  Dir.mkdir(GEM_DIR) unless File.exist?(GEM_DIR)
  `mv *.gem pkg`
end

desc "Build and install the gitnotify gem"
task :install_gem => :gem do
  Dir.chdir(GEM_DIR) do
    `sudo gem install *.gem`
  end
  puts "***********************"
  puts "gitnotify gem installed"
  puts "***********************"
  puts ""
  puts "run 'gitnotify enable-hook' from within a git repository to install a post-commit hook to that will enable Growl broadcasts"
end
