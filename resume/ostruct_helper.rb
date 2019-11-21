require 'ostruct'

class OpenStruct
  def deep_to_h
    to_h.transform_values do |v|
      case v
      when OpenStruct 
        v.deep_to_h
      when Array 
        v.map {|a| a.respond_to?(:deep_to_h) ? a.deep_to_h : a}
      else
        v
      end
    end
  end

  def self.from_object(object)
    # binding.pry
    case object
    when Hash
      OpenStruct.new(Hash[object.map {|k, v| [k, from_object(v)] }])
    when Array
      object.map {|x| from_object(x) }
    else
      object
    end
  end
end