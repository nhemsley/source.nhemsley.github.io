require 'pry'

class Array
  def partition_by
    partitioned = {}
    each_with_object(partitioned) do |v, memo|
      (key, val) = yield(v)
      memo[key] ||= []
      memo[key] << val
      memo
    end
  end
end

module Jekyll
  class Helper < Generator
    def generate(site)
      site.data['resume']['skillset'] = skillset(site)
      site.data['resume']['skillset_html'] = skillset_html(site)
    end

    def skillset(site)
      skillset_with_count(site).map{|skillset| skillset.first}
    end
    
    def skillset_with_count(site)
      site.data['resume']['career'].flat_map{|job| job['tags'] || []}.each_with_object(Hash.new(0)) do |skillset,counts| 
        counts[skillset] += 1
      end.sort{|a, b| a.last <=> b.last}.reverse
    end

    def skillset_html(site)
      ordered = skillset_with_count(site).partition_by{|skillset| [skillset.last, skillset.first]}
      ordered.keys.sort.reverse.map do |key|
        "<div class='skillset-group skillset-#{key}'> #{ordered[key].join(', ')} </div>"
      end.join("\n")
    end
  end
end