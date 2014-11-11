require 'ostruct'
require 'ruby/array/to_deep_ostruct'

class Hash
  def to_deep_ostruct
    object = self.clone
    object.each do |key, value|
      object[key] = value.respond_to?(:to_deep_ostruct) ? value.to_deep_ostruct : value
    end
    OpenStruct.new(object)
  end
end
