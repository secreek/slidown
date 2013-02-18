class MetaParser

    attr_reader :style
    attr_reader :mathjax

    def initialize(str)
        @style = "slidown"
        @mathjax = false
        str.each_line do |line|
            break if line.start_with? "#"
            line = line.chomp
            temp = line.match(/<!--\s+style:\s+(?<style>\w+)\s+-->/)
            @style = temp.nil? ? style : temp[:style]
            @mathjax = true unless line.match(/<!--\s+use:\s+mathjax\s+-->/).nil?
        end
    end

    def enable_mathjax?
        return @mathjax
    end

end
