class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.blank? || URI.regexp =~ value
      record.errors[attribute] << (options[:message] || "is not a valid URL")
    end
  end
end
