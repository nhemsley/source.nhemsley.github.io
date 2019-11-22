require 'nokogiri'
require 'pathname'
require 'pry'

Jekyll::Hooks.register :pages, :post_write do |page|
  # binding.pry
  if page.relative_path == "resume/index.html"
    jc = Jekyll.configuration
    output_dir = Pathname.new(jc['source']).join(jc['destination'])
    output_file = output_dir.join('resume/index-pdf.html')
    doc = Nokogiri::HTML(page.output)
    
    to_clone = doc.css('link').first{|script| script.attr('href').match?('-screen.css')}
    clone = to_clone.clone
    clone.set_attribute('href', clone.attr('href').gsub('-screen.css', '-pdf.css'))

    to_clone.parent.add_child clone

    page_break = doc.css('.job').to_a.select{ |job| job.css('h3').first.children.first.content.match? 'Phone Control Australia'}.first
    page_break.add_previous_sibling('<div class="pdf-break"></div>')

    IO.write(output_file, doc.to_html)
  end
end