require 'yaml'

task :all do
  Rake::Task["build"].invoke
  Rake::Task["resume2pdf"].invoke
end

task :build do
  `jekyll build`  
end

task :resume2pdf do
  config = YAML.load(IO.read '_config.yml')
  output_dir = config['destination'] || '_site'
  Dir.chdir("#{output_dir}/resume") do
    `wkhtmltopdf --disable-javascript index-pdf.html resume.pdf`
  end
end