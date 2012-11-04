class DocumentParser
end

class MarkdownParser < DocumentParser
  def initialize(doc_source)
    @source = doc_source
  end

  def parse
    result = []
    current_node = nil
    current_content = nil

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
        current_content = [line]
      else
        current_content << line if line.strip.length > 0
      end
    end

    current_node[:content] = current_content.join("\n")
    result << current_node
    result
  end
end

