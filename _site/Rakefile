task :all do
  Rake::Task["build"].invoke
  Rake::Task["resume2pdf"].invoke
end

task :build do
  `jekyll build`  
end

task :resume2pdf do
  Dir.chdir('_site/resume')
  `wkhtmltopdf index.html resume.pdf`
  `cp resume.pdf ../../resume`
end