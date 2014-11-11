class Array
  def to_deep_ostruct
    self.clone.map! { |value| value.respond_to?(:to_deep_ostruct) ? value.to_deep_ostruct : value }
  end
end