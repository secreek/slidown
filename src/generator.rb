require 'erb'
require 'fileutils'

class Generator
  def initialize base_path, user, topic, role, meta
    @role = role
    @base_path = base_path
    @user = user
    @topic = topic
    @meta = meta
    FileUtils.remove_dir target_path
    FileUtils.mkpath target_path
  end

  def generate node
    if node
      gen_node node
      generate node.next
    end
  end

  private
  def target_path
    "#{@base_path}/#{@user}/#{@topic}"
  end

  def gen_node node
    # Generate the whole page
    erb = ERB.new open('views/slide_whole.erb').read
    result_file = open("#{target_path}/#{node.id}.html", 'w')
    result_file.write erb.result(binding)
    result_file.flush
    result_file.close

    # Generate partial page for history api
    erb = ERB.new open('views/slide_content.erb').read
    result_file = open("#{target_path}/partial_#{node.id}.html", 'w')
    result_file.write erb.result(binding)
    result_file.flush
    result_file.close
  end
end
