class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(article_id: params[:id])
    binding.pry
end
  end