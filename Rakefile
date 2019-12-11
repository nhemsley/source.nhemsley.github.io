require 'logger'
require 'yaml'
require 'pathname'
require 'git'
require 'pry'

CONFIG = YAML.load(IO.read '_config.yml')

task :build do
  puts "Rollup"
  `rollup -c`
  puts "Jekyll build"
  `jekyll build`  
end

task :resume2pdf do
  output_dir = Pathname.new(CONFIG['destination'] || '_site')
  Dir.chdir(output_dir) do
    `wkhtmltopdf --disable-javascript resume-pdf.html resume.pdf`
  end
end

task :publish  do
  output_dir = Pathname.new(CONFIG['destination'] || '_site')
  git = Git.open(output_dir)
  
  remote = git.remotes.first.url
  puts "Publishing to #{remote}"

  git.add(all: true)
  git.commit('publish')
  git.push
end

task :build_and_publish do
  Rake::Task["build"].invoke
  Rake::Task["resume2pdf"].invoke
  Rake::Task["publish"].invoke
end