require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = `git ls-files -- test/*`.split("\n")
  t.verbose = true
end

desc "Run tests"
task :default => :test