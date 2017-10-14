require 'rake/testtask'

def run(command)
  puts command
  `#{command}`
end

Rake::TestTask.new do |t|
  t.pattern = 'Tests/CarteTests/**/test_*.rb'
  t.warning = false
end

desc "Run tests"
task :default => :test

desc "Install dependencies with bundler"
task :bundle do
  run "bundle install --standalone --path Sources/Carte"
end
