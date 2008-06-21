require 'fileutils'
class GitNotify
  
  def self.run(*args)
    case args.shift
    when "enable-hook"
      enable_notify(*args)
    when "disable-hook"
      disable_notify(*args)
    else
      help
    end
  end

	private
	def self.enable_notify
		if git_repo?
		  FileUtils.chmod 775, post_commit
      append_to_file_if_missing(post_commit, 'growlnotify -m "You just committed, what a dude!"')
      growl "Enabled post-commit"
	  else
	    exit_with! "You're not within a git repository"
    end
	end
	
	def self.disable_notify
	  FileUtils.chmod 664, post_commit
	  growl "Disabled post-commit"
	end
	
	def self.help
	  growl "No docs yet, what a queer"
  end
  
  def self.git_repo?
    File.exists?(repo_path)
  end
  
  # Just a standard helper
  def self.repo_path
    File.join(Dir.pwd, ".git")
  end
  
  def self.post_commit
    File.join(repo_path, "hooks", "post-commit")
  end
  
  def self.growl(message)
    system "growlnotify -m #{message}"
  end
  
  def self.exit_with!(message)
    STDERR.puts message
    exit!
  end
  
  # Pinched from deprec / capistrano_extensions.rb
  def append_to_file_if_missing(filename, value, options={})
    sudo <<-END
    sh -c '
    grep -F "#{value}" #{filename} > /dev/null 2>&1 || 
    test ! -f #{filename} ||
    echo "#{value}" >> #{filename}
    '
    END
  end
end