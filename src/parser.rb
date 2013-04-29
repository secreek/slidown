class DocumentParser
end

class MarkdownParser < DocumentParser
  def initialize(doc_source)
    @uuid   = UUID.new.generate
    @source = doc_source
    @parse_block = {list:[]}
  end

  def parse
    result = []
    voting_id = 0
    voting_count = 0
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
        # Chart-Bar PreProcess
        # See transform rules in docs/slidown_spec.md
        if line.start_with?("=>") && line.strip.end_with?("~~Bar")
            current_content += parse_chart(line)
        elsif line.strip.start_with?("(?)") ||
              line.strip.start_with?("[?]")
            current_content << "<div class=\"voting-group\">" if voting_count == 0
            current_content << parse_voting(line, voting_count, voting_id)
            voting_count += 1
        elsif line.strip.match (/[\+\-][\s]+./)
            @parse_block[:list] << line.strip
        else
            if voting_count > 0
                current_content << "</div>" 
                voting_count = 0 
                voting_id += 1
            end
            current_content << parse_list.clone unless @parse_block[:list].empty?
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
        e.strip!
        data = e.scan(/\d+$/).last
        term = e[0..-(data.size + 2)] # This is dirty but magic, you're not suppose to understand.
        html << sprintf("<div class=\"bar-%s\">%s</div>", data, term)
    end
    html << "</div>"
  end

  def parse_voting(list, value, gid)
      list.strip!
      type, term = list[0..2], list[4..-1]
      type = type == "(?)" ? "radio" : "checkbox"
      id = sprintf("%s-%d-%d", @uuid, gid, value)
      sprintf("<div><span class=\"%s\"></span><input type=\"%s\" value=\"%s\">%s</div>", id, type, id, term)
  end

  def parse_list()
      result = []
      type = @parse_block[:list][0] =~ /[\+\-]/ ? "ul" : "ol"
      if @parse_block[:list].size > 5
        result << sprintf("<%s class=\"long-list\">", type)
      else
        result << sprintf("<%s>", type)
      end
      @parse_block[:list].each do |list|
          list = list.scan(/[\+\-\d]\.*\s*(?<term>.+)/).last.first
          accum = 0
          list.each_char {|c| accum += c.bytesize > c.size ? 2 : 1}
          if accum > 20
              result << sprintf("<li class=\"long-line\">%s</li>", list)
          else
              result << sprintf("<li>%s</li>", list)
          end
      end
      @parse_block[:list].clear 
      result << sprintf("</%s>", type)
      result
  end

end

