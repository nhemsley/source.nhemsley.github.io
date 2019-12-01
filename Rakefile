require 'logger'
require 'yaml'
require 'pathname'
require 'git'
require 'pry'

CONFIG = YAML.load(IO.read '_config.yml')

task :all do
  Rake::Task["build"].invoke
  Rake::Task["resume2pdf"].invoke
end

task :build do
  `jekyll build`  
end

task :resume2pdf do
  output_dir = Pathname.new(CONFIG['destination'] || '_site')
  Dir.chdir(output_dir.join('resume')) do
    `wkhtmltopdf --disable-javascript index-pdf.html resume.pdf`
  end
end

task :publish => [:all] do
  output_dir = Pathname.new(CONFIG['destination'] || '_site')
  git = Git.open(output_dir)
  
  remote = git.remotes.first.url
  puts "Publishing to #{remote}"

  git.add(all: true)
  git.commit('publish')
  git.push
end