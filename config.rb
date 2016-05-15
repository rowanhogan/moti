
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :autoprefixer
activate :directory_indexes
activate :livereload
activate :dotenv

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
  activate :asset_hash
end

helpers do
  # def some_helper
  #   "Helping"
  # end
end

data.moti.page.each do |id, page|
  proxy "/#{page[:slug]}.html", '/page.html', :ignore => true, :locals => { page: page }
end

activate :contentful do |f|
  f.space         = { moti: ENV['CONTENTFUL_SPACE_ID'] }
  f.access_token  = ENV['CONTENTFUL_API_KEY']
  f.content_types = {
    page: 'page',
    exhibition: 'exhibition'
  }
end
