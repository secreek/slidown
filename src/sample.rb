require_relative 'parser'
require_relative 'builder'
require_relative 'generator'

mp = MarkdownParser.new(open('../docs/sample.md').read)
b = Builder.new mp.parse
g = Generator.new '../docs/'
g.generate b.build_tree
