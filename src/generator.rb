require 'erb'

class Generator
  def initialize base_path
    @base_path = base_path
  end

  def generate node
    gen_node node

    # first iterate through child
    if node.first_child
      generate node.first_child
    end
    # next, interate through sibling
    if node.next_sib
      generate node.next_sib
    end
  end

  private
    def gen_node node
      erb = ERB.new open('templates/html.erb').read
      open("#{@base_path}/#{node.id}.html", 'w').write erb.result(binding)
    end
end
