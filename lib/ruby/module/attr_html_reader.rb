require 'github/markup'

class Module
  def attr_html_reader name, type = :default
    case type
      when :markdown
        define_method "#{name}_html".to_sym do
          data = send(name)
          data ? GitHub::Markup.render("#{name}.markdown", data) : ''
        end
      when :nl
        define_method "#{name}_html".to_sym do
          data = send(name)
          data ? "<p>#{data.gsub(/(\r?\n\s*){2,}/,'</p><p>').gsub(/\r?\n\s*/,'<br>')}</p>" : ''
        end
      else
        define_method "#{name}_html".to_sym do
          data = send(name)
          data ? data : ''
        end
    end
  end
end