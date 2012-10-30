require_relative 'entity'

module Markdown
  def document
  end
end

class DocumentParser
end

class MarkdownParser < DocumentParser
  def initialize(doc_source)
    @source = doc_source
  end

  def parse
    result = []
    current_node = nil
    current_list = nil

    @source.each_line do |line|
      line = line.strip
      next if line.length == 0
      if line.start_with? '#'
        if current_node
          current_node[:content] = ListEntity.new current_list if current_list
          result << current_node
        end

        current_node = {}
        level = line.match(/#*/)[0].length
        current_node[:level] = level
        current_node[:title] = TitleEntity.new line[level..-1].strip
      elsif line.start_with? '!['
        raise "Missing title before #{line}" unless current_node
        current_node[:content] = ImgEntity.new line[(line.index('(') + 1)..(line.index(')') - 1)]
      elsif line.start_with? '-'
        raise "Missing title before #{line}" unless current_node
        current_list ||= []
        current_list << line[1..-1].strip
      else
        current_node[:content] = TextEntity.new line
      end
    end

    result << current_node
    result
  end
end

mp = MarkdownParser.new(open('../docs/sample.md').read)
puts mp.parse
