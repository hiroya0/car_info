class HomesController < ApplicationController
  def index
    @users = User.all
    @bookmarks = current_user.bookmarks.includes(:article)
  end
end
