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
  puts "gitnotify gem installed"
  puts "gitnotify enable-hook in a git repositoy to install the post-commit hook to enable Growl broadcasts"
end
