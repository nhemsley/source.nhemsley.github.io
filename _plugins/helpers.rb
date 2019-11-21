require 'pry'
module Jekyll
  class Helper < Generator
    def generate(site)
      site.data['resume']['skillset'] = site.data['resume']['career'].flat_map{|job| job['tags'] || []}.each_with_object(Hash.new(0)) do |skillset,counts| 
        counts[skillset] += 1
      end.sort{|a, b| a.last <=> b.last}.reverse.map{|skillset| skillset.first}

    end
  end
end