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

  def initialize
    @html = []
  end

  def add_item item

    flag  = ""
    accum = 0
    item  = item.scan(/[\+\-\d]\.*\s*(?<term>.+)/).last.first
    item.each_char {|c| accum += c.bytesize > c.size ? 2 : 1}
    flag  = " class=\"long-line\"" if accum > 20
    @html << sprintf("<li%s>%s</li>", flag, item) 

  end

  def to_s
    render
  end

  def render
    flag = @html.size > 5 ? " class=\"long-list\"" : ""
    (["<ul#{flag}>"] + @html + ["</ul>"]).join("\n")
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
    @html.join("\n")
  end

end


class VoteEntity < SlideEntity

  def initialize vid
    @vid   = vid
    @uuid  = UUID.new.generate
    @count = 0
    @html  = ["<div class=\"voting-group\">"]
  end

  def add_item item
    type, term = item[0..2], item[3..-1].strip
    type = type == "(?)" ? "radio" : "checkbox"
    id = sprintf("%s-%d-%d", @uuid, @vid, @count)
    @html << sprintf("<div><span class=\"%s\"></span><input type=\"%s\" value=\"%s\">%s</div>", id, type, id, term)
    @count += 1
  end

  def render
    (@html + ["</div>"]).join("\n")
  end
end
