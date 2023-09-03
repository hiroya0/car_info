class NewsController < ApplicationController
  require "open-uri"
   
  def index
    @articles = fetch_articles_from_news_api
  end
end
