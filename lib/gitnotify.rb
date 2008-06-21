require 'fileutils'
class GitNotify
  
  def self.run(*args)
    case args.shift
    when "enable-hook"
      enable_notify
    when "disable-hook"
      disable_notify
    else
      help
    end
  end

	private
	def self.enable_notify
    exit_with! "You're not within a git repository" unless git_repo?
    FileUtils.chmod 0775, post_commit
    unless applied_hook?
      File.open(post_commit, "w+") do |f|
        f << File.read(post_commit_script)
      end
    end
    puts "Gitnotify: Enabled post-commit"
  end
	
	def self.disable_notify
	  FileUtils.chmod 0664, post_commit
	  puts "Gitnotify: Disabled post-commit"
	end
	
	def self.help
	  puts <<-END

=========================
Gitnotify, railscamp love
=========================

  Tell your peeps about your commits using growl
	      
  Usage: (from within a git repo): gitnotify <command>
	        
  enable-hook
	  Enables a post-commit hook
      
  disable-hook
    Disables a post-commit hook
END
  end
  
  def self.git_repo?
    File.exists?(repo_path)
  end
  
  def self.applied_hook?
    File.read(post_commit).include?('growlnotify')
  end
  
  # Just a standard helper
  def self.repo_path
    File.join(Dir.pwd, ".git")
  end
  
  def self.post_commit
    File.join(repo_path, "hooks", "post-commit")
  end
  
  def self.post_commit_script
    File.join(File.dirname(__FILE__), "..", "supports", "post-commit")
  end

  def self.exit_with!(message)
    STDERR.puts message
    exit!
  end
end