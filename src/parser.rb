class DocumentParser
end

class MarkdownParser < DocumentParser
  def initialize(doc_source)
    @source = doc_source
  end

  def parse
    result = []
    entity  = nil
    voting_id = 0
    current_node = nil
    current_content = []
     
    @source.each_line do |line|
      if entity.is_a? CodeEntity
	if line.start_with? "```"
            current_content << entity.render
            entity = nil
        else
            entity.add_item line
        end
        next
      end
        
      if line.strip.start_with?('#')
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
        if line.start_with?("=>") && line.strip.end_with?("~~Bar")
	  # Process the Chart in entity.rb 
          # See transform rules in docs/slidown_spec.md
       	  current_content << ChartEntity.new(line).render
        elsif line.strip.start_with?("(?)") ||
              line.strip.start_with?("[?]")
          # Process the Voting
          # See transform rules in docs/slidown_spec.md
          unless entity.is_a?(VoteEntity)
            entity = VoteEntity.new(voting_id)
            voting_id += 1
          end
          entity.add_item(line.strip)
        elsif line.strip.match (/[\+\-][\s]+./)
          # Process the List
          # This just process the ul list.
          # See transform rules in docs/slidown_spec.md
          unless entity.is_a?(ListEntity)
            entity = ListEntity.new
          end
          entity.add_item(line.strip)
        elsif line.strip.start_with? "```"
          entity = CodeEntity.new(*line[3..-1].split)
        else
          # If there's an empty line, a entity must come to an end.
          # But if there's a CodeEntity, there must be something.
	  if entity.is_a? CodeEntity
             entity.add_item line
	  elsif line.strip.length > 0
            current_content << line
          elsif !entity.nil?
            current_content << entity.render
            entity = nil
          end
        end
      end
    end

    current_node[:content] = current_content.join("\n")
    result << current_node
    result
  end

end

