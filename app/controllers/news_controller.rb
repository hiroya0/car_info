class NewsController < ApplicationController
    def index
        require 'news-api'
        news = News.new(ENV['NEWS_API_KEY'])
        @news = news.get_top_headlines(country: 'jp')
    end
end
