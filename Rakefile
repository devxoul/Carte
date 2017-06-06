require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'Tests/CarteTests/**/test_*.rb'
  t.warning = false
end

desc "Run tests"
task :default => :test
