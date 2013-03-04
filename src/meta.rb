class MetaParser

    attr_reader :style
    attr_reader :mathjax

    def initialize(str)
        @style = "slide"
        @mathjax = false
        style_regexp = /<!--\s+style:\s+(?<style>\w+)\s+-->/
        mathjax_regexp = /<!--\s+use:\s+mathjax\s+-->/
        str.each_line do |line|
            break if line.start_with? "#"
            line = line.chomp
            temp = line.match(style_regexp)
            @style = temp.nil? ? style : temp[:style]
            @mathjax = true unless line.match(mathjax_regexp).nil?
        end
    end

    def enable_mathjax?
        return @mathjax
    end

end
