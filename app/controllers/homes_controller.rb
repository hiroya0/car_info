class HomesController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all
      @bookmarks = current_user.bookmarks.includes(:article)
      @latest_articles = Article.order(updated_at: :desc).limit(3)
    else
      @users = User.all
    end
  end
end
