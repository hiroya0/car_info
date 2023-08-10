require 'news-api'
require 'uri'

class NewsController < ApplicationController
    def index
        news = News.new(ENV['NEWS_API_KEY'])
        keywords = ['トヨタ']
        encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
        query = encoded_keywords.join('OR')
        @articles = news.get_everything(language: 'jp', q: query).map do |article|
            Article.create(
              title: article.title,
              url: article.url,
              image_url: article.urlToImage
            )
        end
    end
   
    def show
      @article = Article.find(params[:id])
    end
end

