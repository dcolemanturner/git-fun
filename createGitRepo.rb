require 'rugged'

dir_name = "git-test"

if !Dir.exists? dir_name
	Dir.mkdir(dir_name)
end

##todo: this object is returning a plain string.  We need to return a full repository object in ordee to write commits
## it's also having difficulty locating the directory_name folder.
repo = Rugged::Repository.discover("/" + dir_name + "/")
puts repo.inspect

if repo.empty?
	puts "Repo is empty"
	repo = Rugged::Repository.init_at dir_name
end

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

