# This is a meta infomation parser for slidown
# 
# Author: DeathKing
# License: MIT


class MetaParser

    attr_reader     :proper
    REGEXPS = {
        animation: /\s*animation:\s*(?<animation>\w+)\s*/,
        style:     /\s*style\s*:\s*(?<style>\w+)\s*/,
        theme:     /\s*theme:\s*(?<theme>\w+)\s*/,
        use:       /\s*use\s*:\s*(?<plugin>\w+)\s*/,
    }

    def initialize(str)
        @proper = {
            style: "slide",
            theme: "slide",
            use: [],
        }
        strblk = ""
        str.each_line do |line|
            strblk << line
            break if line.strip.end_with? "-->"
        end
        strblk.gsub! "<!--",""
        strblk.gsub! "-->",""
        parse_block(strblk)
        self
    end

    def parse_block(string_block)
      return nil unless string_block.respond_to? :split
      string_block.split(/[;|\n|\r]/).each do |line|
        line = line.chomp.strip
        line.match(REGEXPS[:animation]) { |m| @proper[:animation] = m[1] }
        line.match(REGEXPS[:theme]) { |m| @proper[:theme] = m[1] }
        line.match(REGEXPS[:style]) { |m| @proper[:style] = m[1] }
        line.match(REGEXPS[:use])   { |m| @proper[:use] << m[1] }
      end
    end

    def enable_mathjax?
        return @proper[:use].include? /mathjax/i
    end

    def method_missing(name, *arg)
        @proper[name.to_s.downcase.to_sym]
    end

    def style;      @proper[:style];     end
    def animation;  @proper[:animation]; end
    def theme;      @proper[:theme];     end
    def use;        @proper[:use];       end

end
