require 'erb'
require 'fileutils'

class Generator
<<<<<<< HEAD
  def initialize base_path, user, topic, role, meta
=======
  def initialize base_path, user, topic, role
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
    @role = role
    @base_path = base_path
    @user = user
    @topic = topic
<<<<<<< HEAD
    @meta = meta
=======
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
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
      erb = ERB.new open('views/html.erb').read
      result_file = open("#{target_path}/#{node.id}.html", 'w')
      result_file.write erb.result(binding)
      result_file.flush
      result_file.close
    end
end
