require 'news-api'
require 'uri'

class NewsController < ApplicationController
 def index
   news = News.new(ENV['NEWS_API_KEY'])
   keywords = ['トヨタ']
   encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
   query = encoded_keywords.join('OR')
   @article = news.get_everything(language: 'jp', q: query)
   @article.each do |article_data|
    article = Article.new(
      title: article_data.title,
      url: article_data.url,
      image_url: article_data.urlToImage
    )
    article.save
    end
 end

 def show
   news = News.new(ENV['NEWS_API_KEY'])
   keywords = ['トヨタ']
   encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
   query = encoded_keywords.join('OR')
   @article = news.get_everything(language: 'jp', q: query)
   @comment = Coment.new
 end
end

