require 'erb'
require 'fileutils'

class Generator
  def initialize base_path, user, topic, role
    @role = role
    @base_path = base_path
    @user = user
    @topic = topic
    FileUtils.mkpath target_path
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
    def target_path
      "#{@base_path}/#{@user}/#{@topic}"
    end

    def gen_node node
      erb = ERB.new open('templates/html.erb').read
      result_file = open("#{target_path}/#{node.id}.html", 'w')
      result_file.write erb.result(binding)
      result_file.flush
      result_file.close
    end
end
