class DocumentParser
end

class MarkdownParser < DocumentParser
  def initialize(doc_source)
    @source = doc_source
  end

  def parse
    result = []
    current_node = nil
    current_content = []
    @source.each_line do |line|
      if line.strip.start_with? '#'
        if current_node
          current_node[:content] = current_content.join("\n")
          result << current_node
        end

        current_node = {}
        level = line.match(/#*/)[0].length
        current_node[:level] = level
        title = line.match(/[^# ][^#]*/)
        if title
          title = title[0]
        else
          title = ""
        end
        current_node[:title] = title
        current_content = (line.strip.end_with?("#") ? [] : [line])
      else
        # Chart-Bar PrrProcess
        # See Transform rule in docs/slidown_spec.md
        if line.start_with?("=>") && line.strip.end_with?("~~Bar")
            current_content += parse_chart(line)
        else
            current_content << line if line.strip.length > 0
        end
      end
    end

    current_node[:content] = current_content.join("\n")
    result << current_node
    result
  end

  def parse_chart(exp)
    
    html = ["<div class=\"chart-bar\">"]
    exp.gsub!("~~Bar", "")
    ary = exp.split(/[<]*=>/)
    ary.each do |e|
        next if e.empty?
        e = e.strip.split(/[ ]+/)
        html << sprintf("<div class=\"bar-%s\">%s</div>", e[1], e[0])
    end
    html << "</div>"
  end

end

