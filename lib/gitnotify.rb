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
    exit_with! "You've already enabled the hook" if applied_hook?
	  File.open(post_commit, "w+") do |f|
	    f << File.read(post_commit_script)
	  end
	  FileUtils.chmod 0775, post_commit
    growl "Gitnotify", "Enabled post-commit"
	end
	
	def self.disable_notify
	  FileUtils.chmod 0664, post_commit
	  growl "Gitnotify", "Disabled post-commit"
	end
	
	def self.help
	  growl "No docs yet", "What a queer"
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
    File.join(__FILE__, "..", "supports", "post-commit")
  end
  
  def self.growl(title, message)
    system "growlnotify -t #{title} -m #{message}"
  end
  
  def self.exit_with!(message)
    STDERR.puts message
    exit!
  end
end