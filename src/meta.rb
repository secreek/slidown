# This is a meta infomation parser for slidown
# 
# Author: DeathKing
# License: MIT


class MetaParser

    attr_reader     :proper
    REGEXPS = {
        animation: /\s+animation:\s+(?<animation>\w+)\s+/,
        style:     /\s+style:\s+(?<style>\w+)\s+/,
        theme:     /\s+theme:\s+(?<theme>\w+)\s+/,
        use:       /\s+use:\s+(?<plugin>\w+)\s+/,
        meta:      /^<!--[\w|\d|\s]+-->/m,
    }

    def initialize(str)
        @proper = {
            style: "slide",
            theme: "slide",
            use: [],
        }
        parse_block(str.scan(REGEXPS[:meta]))
        self
    end

    def parse_block(string_block)
      return nil unless string_block.respond_to? :split
      string_block.split(/[;|\n|\r]/).each do |line|
        line = line.chomp!.strip!
        line.match(REGEXPS[:animation]) { |m| @porper[:animation] = m[1] }
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

end
