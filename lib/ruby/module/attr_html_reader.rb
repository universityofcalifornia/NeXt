require 'github/markup'

class Module
  def attr_html_reader name, type = :markdown
    case type
      when :markdown
        define_method "#{name}_html".to_sym do
          GitHub::Markup.render("#{name}.markdown", send(name))
        end
      when :nl
        define_method "#{name}_html".to_sym do
          "<p>#{send(name).gsub(/(\r?\n\s*){2,}/,'</p><p>').gsub(/\r?\n\s*/,'<br>')}</p>"
        end
    end
  end
end