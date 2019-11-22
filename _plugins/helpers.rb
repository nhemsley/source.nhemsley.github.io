require 'cgi'
require 'securerandom'

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
      @site = site
      site.data['resume']['skillset'] = skillset(site)
      site.data['resume']['skillset_html'] = skillset_html(site)
      site.data['resume']['skillset_for_js'] = skillset_for_js(site)
      site.data['build_id'] = SecureRandom.hex
      touch_referee_names(site)

    end

    def touch_referee_names(site)
      site.data['resume']['referees'] = site.data['resume']['referees'].map do |referee|
        referee['full_name'] = [referee['first_name'], referee['middle_name'], referee['last_name']].reject(&:nil?).reject(&:empty?).join(' ')
        referee
      end
    end

    def skillset(site)
      skillset_with_count(site).map{|skillset| skillset.first}
    end
    
    def skillset_with_count(site)
      site.data['resume']['career'].flat_map{|job| job['tags'] || []}.each_with_object(Hash.new(0)) do |skillset,counts| 
        counts[skillset] += 1
      end.sort{|a, b| a.last <=> b.last}.reverse
    end

    def skillset_partitioned_by_count(site)
      skillset_with_count(site).partition_by{|skillset| [skillset.last, skillset.first]}
    end

    def skillset_html(site)
      partitioned = skillset_partitioned_by_count(site)
      partitioned.keys.sort.reverse.map do |key|
        "<div class='skillset-group skillset-#{key}'> #{partitioned[key].join(', ')} </div>"
      end.join("\n")
    end


    def skillset_for_js(site)
      CGI.escapeHTML(JSON.dump(skillset_partitioned_by_count(site)))
    end
  end
end