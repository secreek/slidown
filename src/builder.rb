require 'markdown'
#require 'rdiscount'

class Node
  attr_accessor :id, :title, :content, :level
  attr_accessor :parent, :prev_sib, :next_sib, :first_child

  def initialize hash, id
    @id = id
    @title = hash[:title]
    @level = hash[:level]
    @content = hash[:content]
    @parent = @prev_sib = @next_sib = @first_child = nil
  end

  def content
    Markdown.new(@content).to_html if @content.strip.length > 0
    #RDiscount.new(@content).to_html if @content.strip.length > 0
  end

  def to_s
    @id.to_s
  end

  def next
    if @first_child # first iterate through child
      @first_child
    elsif @next_sib # next, interate through sibling
      @next_sib
    else
      return nil if @parent == nil; # Solo
      node = @parent;
      while node != nil && node.next_sib == nil
        node = node.parent
        return nil if node == nil
      end
      node.next_sib
    end
  end
end

class Builder
  def initialize list
    @element_list = list
    @id = 1
  end

  def build_tree
    nil if @element_list.length == 0
    root = Node.new @element_list[0], @id
    @id += 1
    prev_node = root
    @element_list[1..-1].each do |element|
      new_node = Node.new element, @id
      @id += 1

      if prev_node.level == new_node.level # we are siblings
        new_node.parent = prev_node.parent
        new_node.prev_sib = prev_node
        prev_node.next_sib = new_node
      # what if # => ### ?
      # it should be okay
      elsif new_node.level >= (prev_node.level + 1) # first child
        new_node.parent = prev_node
        prev_node.first_child = new_node
      else # parent's sibling
        sibling = prev_node
        while sibling.level > new_node.level
          sibling = sibling.parent
        end
        new_node.prev_sib = sibling
        sibling.next_sib = new_node
        new_node.parent = sibling.parent
      end

      prev_node = new_node
    end

    root
  end
end
