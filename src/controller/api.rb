require 'sinatra'
require 'sinatra/namespace'

################################
#                              #
# Stop Maintaining for a while #
#                              #
################################
namespace '/api' do
  post '/github_hooks' do
    push = JSON.parse(params[:payload])
    @user = push['repository']['owner']['name']
    @topic = push['repository']['name']
    @path = "https://api.github.com/repos/#{@user}/#{@topic}/contents/README.md"

    # Full control
    uri = URI("http://slidown.com/api/#{@user}/#{@topic}/upload") # FIXME - Using Constants

    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri.request_uri
      request.set_form_data({"github_path" => @path})

      response = http.request request # Net::HTTPResponse object
    end
  end

  # try to provide an api for file upload
  post '/:user/:topic/upload' do
    @user = params[:user]
    @topic = params[:topic]
    @path = params[:github_path]

    data = JSON.load(open(@path).read)
    @file_content = Base64.decode64(data['content'])

    parser = MarkdownParser.new(@file_content)
    builder = Builder.new parser.parse
    generator = Generator.new base_path, @user, @topic, 'guide'
    generator.generate builder.build_tree

    'Success!'
  end
end
