class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(article_id: params[:id])
    
    unless @article
      all_articles = fetch_articles_from_news_api
      @article = all_articles.find { |article| article["url"][/(\d+)(?!.*\d)/].to_i == params[:id].to_i }
    end
  end
end
