class NewsController < ApplicationController
  require "open-uri"
   
  def index
      news_api_key = ENV['NEWS_API_KEY']
      keyword = "トヨタ"  
      encoded_keyword = URI.encode_www_form_component(keyword)
      uri = "https://newsapi.org/v2/everything?q=#{encoded_keyword}&sortBy=popularity&apiKey=#{news_api_key}"
      article_serialized = open(uri).read
      all_articles = JSON.parse(article_serialized)["articles"]
      
      # IDが0の記事をフィルタリング
      @articles = all_articles.select do |article|
          article["url"][/(\d+)(?!.*\d)/].to_i != 0
      end

      @articles.each do |article|
          article_id = article["url"][/(\d+)(?!.*\d)/].to_i
          Rails.logger.info("URL: #{article["url"]}, Extracted article_id: #{article_id}")
          
          # 既にデータベースに存在する記事でないことを確認
          next if Article.exists?(article_id: article_id)
        
          article_instance = Article.new(
            title: article["title"],
            description: article["description"],
            url: article["url"],
            article_id: article_id,
            urlToImage: article["urlToImage"]
          )
          article_instance.save!
      end
  end
end