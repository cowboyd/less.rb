require 'rubygems'
require './lib/less'
Gem::Specification.new do |gemspec|
  $gemspec = gemspec
  gemspec.name = gemspec.rubyforge_project = "less"
  gemspec.version = Less::VERSION
  gemspec.summary = "Leaner CSS, in your browser or Ruby (via less.js)"
  gemspec.description = "Invoke the Less CSS compiler from Ruby (http://lesscss.org)"
  gemspec.email = "cowboyd@thefrontside.net"
  gemspec.homepage = "http://github.com/cowboyd/less.rb"
  gemspec.authors = ["Charles Lowell"]
  gemspec.extra_rdoc_files = ["README.md"]
  gemspec.executables = ["lessc"]
  gemspec.add_dependency("therubyracer", ">= 0.7.5")
  gemspec.files = Rake::FileList.new("**/*").tap do |manifest|
    manifest.exclude "*.gem"
  end
end

desc "Build gem"
task :gem => :gemspec do
  Gem::Builder.new($gemspec).build
end

desc "build the gemspec"
task :gemspec => :clean do
  File.open("#{$gemspec.name}.gemspec", "w") do |f|
    f.write($gemspec.to_ruby)
  end
end

task :clean do
  sh "rm -rf *.gem"
end

for file in Dir['tasks/*.rake']
  load file
end
