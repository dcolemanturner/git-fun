require 'rugged'

dir_name =  Dir.pwd + "/" + "git-test"
git_repo = dir_name + '/.git/'

if !Dir.exists? dir_name
	Dir.mkdir(dir_name)
end

##todo: this object is returning a plain string.  We need to return a full repository object in order to write commits
## it's also having difficulty locating the directory_name folder.

repo = Rugged::Repository.discover(dir_name)
puts "Repo inspection in find method: " + repo.inspect
puts "Expected repo Dir: " + git_repo
puts repo.class

if repo != git_repo
	puts "repo missing! \n\n"
	#instantiate the repo because it is not there!
	repo = Rugged::Repository.init_at dir_name
	puts "Repo inspection post init: " + repo.inspect
	puts repo.class
else 
	puts "repo found! \n\n"
	#instantiate a repo class with existing git repo

end

#will have a valid repo object by now

#load copy 1.0 to start the repo
File.open( dir_name + "/out.txt", 'w') {|f| f.write( "Version 1.0: line of information" ) }

puts repo.class

puts repo.head_orphan?

puts repo.path

puts repo.workdir

ref = repo.head

=begin
oid = repo.write("This is a blob.", :blob)
index = Rugged::Index.new
index.add(:path => "README.md", :oid => oid, :mode => 0100644)

options = {}
options[:tree] = index.write_tree(repo)

options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
options[:message] ||= "Making a commit via Rugged!"
options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
options[:update_ref] = 'HEAD'

Rugged::Commit.create(repo, options)
=end

