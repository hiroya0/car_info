class NewsController < ApplicationController
    require "open-uri"
     
    def index
      news_api_key = ENV['NEWS_API_KEY']
      keyword = "トヨタ"  
      encoded_keyword = URI.encode_www_form_component(keyword)
      uri = "https://newsapi.org/v2/everything?q=%E3%83%88%E3%83%A8%E3%82%BF&sortBy=popularity&apiKey=#{news_api_key}"
      article_serialized = open(uri).read
      @articles = JSON.parse(article_serialized)
        
      @articles["articles"].each do |article|
        begin
            article_id = article["url"][/(\d+)(?!.*\d)/].to_i
            Rails.logger.info("URL: #{article["url"]}, Extracted article_id: #{article_id}")
            # 0や異常な値が得られた場合は次の記事へ
            next if article_id == 0
            
            # 既にデータベースに存在する記事でないことを確認
            next if Article.exists?(article_id: article_id)

            article_instance = Article.new(
              title: article["title"],
              description: article["description"],
              url: article["url"],
              article_id: article_id,
              image_url: article["image_url"]
            )
            article_instance.save!
        end
      end
      @db_articles = Article.all  # ループの外で1回だけ全記事を取得
    binding.pry
    end
  
    def show
      @article = Article.find(params[:id])
    end
end