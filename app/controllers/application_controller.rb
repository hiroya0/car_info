class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def fetch_articles_from_news_api(keyword = "トヨタ")
    news_api_key = ENV['NEWS_API_KEY']
    encoded_keyword = URI.encode_www_form_component(keyword)
    uri = "https://newsapi.org/v2/everything?q=#{encoded_keyword}&sortBy=popularity&apiKey=#{news_api_key}"
    article_serialized = open(uri).read
    all_articles = JSON.parse(article_serialized)["articles"]
  
    puts all_articles
    # データベースに存在する記事のIDを取得
    existing_article_ids = Article.pluck(:article_id)
  
    # 取得したニュースの中で、データベースに存在するものだけを選び出す
    all_articles.select do |article|
      article_id = article["url"][/(\d+)(?!.*\d)/].to_i
      existing_article_ids.include?(article_id) && article_id != 0
    end
  end
  
end
