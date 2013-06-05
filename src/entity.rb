class SlideEntity
  def render
    raise "Not Implemented"
  end
end

class TitleEntity < SlideEntity
  attr_accessor :title

  def initialize title
    @title = title.strip
  end

  def to_s
    render
  end

  def render
    "<h1>#{@title}</h1>"
  end
end

class TextEntity < SlideEntity
  attr_accessor :text

  def initialize text
    @text = text.strip
  end

  def to_s
    render
  end

  def render
    "<p>#{@text}</p>"
  end
end

class ImgEntity < SlideEntity
  attr_accessor :img_url

  def initialize url
    @img_url = url.strip
  end

  def to_s
    render
  end

  def render
    "<img src='#{@img_url}'></img>"
  end
end

class ListEntity < SlideEntity
  attr_accessor :items

  def initialize items
    @items = items
  end

  def to_s
    render
  end

  def render
    item_list = ""
    @items.each do |item|
      item_list << "<li>#{item}</li>"
    end
    "<ul>#{item_list}</ul>"
  end
end

class ChartEntity < SlideEntity

  def initialize line

    @html = ["<div class=\"chart-bar\">"]
    line.gsub("~~Bar", "").split(/[<]*=>/).each { |e|
      next if e.empty?
      e.strip!
      data = e.scan(/\d+$/).last
      term = e[0..-(data.size + 2)]
      @html << sprintf("<div class=\"bar-%s\">%s</div>", data, term)
    }
    @html << "</div>"

  end

  def render
    @html.join("\n").to_s
  end

end


class VoteEntity < SlideEntity

  def initialize
  end

  def render
  end
end

puts ChartEntity.new("=>Slidown 30<=>Magic Pad 40<=>Default asdu 92 80~~Bar").render
