require 'news-api'
require 'uri'

class NewsController < ApplicationController
 def index
   news = News.new(ENV['NEWS_API_KEY'])
   keywords = ['新車','自動車産業']
   encoded_keywords = keywords.map { |keyword| URI.encode_www_form_component(keyword) }
   query = encoded_keywords.join(',')
   @news = news.get_everything(language: 'jp', q: query)
 end
end

