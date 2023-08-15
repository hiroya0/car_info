class NewsController < ApplicationController
    def index
      news = News.new(ENV['NEWS_API_KEY'])
      keywords = ['トヨタ']
      encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
      query = encoded_keywords.join('OR')
   
      @articles = news.get_everything(language: 'jp', q: query).map do |article|
        existing_article = Article.find_or_initialize_by(url: article.url)
   
        unless existing_article.new_record?
          existing_article.update(
            title: article.title,
            image_url: article.urlToImage,
            description: article.description
          )
        end
        existing_article       
      end
      binding.pry
    end

    def show
        @article = Article.find(params[:id])
        binding.pry
      end
end