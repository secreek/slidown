require 'sinatra'

put '/:user/:doc' do
  src_url = params[:src]
  # Grab it
  doc_source = download(src_url)
  parser = MarkdownParser.new(doc_source)
  end
end

get '/:user/:doc' do
end

get '/:user/:doc/:page' do
end
