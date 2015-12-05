class String
  def ellipsis maxlength
    if length > maxlength
      return self[0...maxlength] + "..."
    else
      return self
    end
  end
end
