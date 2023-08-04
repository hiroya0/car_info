require 'news-api'
require 'uri'

class NewsController < ApplicationController
 def index
   news = News.new(ENV['NEWS_API_KEY'])
   keywords = ['トヨタ']
   encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
   query = encoded_keywords.join('OR')
   @news = news.get_everything(language: 'jp', q: query)
 end

 def show
   news = News.new(ENV['NEWS_API_KEY'])
   keywords = ['トヨタ']
   encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
   query = encoded_keywords.join('OR')
   @news = news.get_everything(language: 'jp', q: query)
   @comment = Coment.new
 end
end

