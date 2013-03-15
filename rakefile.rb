task :test_global do                            # if testing after gem install
  ruby "test/test_rs232-sigmakoki.rb"
end

task :test_local  do                            # if testing from gem root dir
  ruby "-Ilib test/test_rs232-sigmakoki.rb"
end

task :gem_build   do
  sh "gem build rs232-sigmakoki.gemspec"
end

task :gem_install => :gem_build do 
  gemfile = Dir.new("./").entries.select{ |f| 
    f =~ /rs232-sigmakoki-[\d]+\.[\d]+\.[\d]+.gem/  # auto-get find current vers 
  }.sort[-1]
  sh "gem install --local %s" % gemfile
end

task :default => :test_local
