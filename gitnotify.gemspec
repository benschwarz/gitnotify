Gem::Specification.new do |s|
  s.name = "gitnotify"
  s.version = "0.0.1"
  s.date = "2008-06-21"
  s.summary = "Tell all your jour peeps about your commits"
  s.homepage = "http://railscamp.net"
  s.description = s.summary
  s.authors = ["Ben Schwarz", "Tim Lucas"]
  s.files = ["bin/gitnotify", "lib/gitnotify.rb", "supports/post-commit"]
  s.require_path = "lib"
  s.executables = "gitnotify"
end