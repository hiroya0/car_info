class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    binding.pry
  end
  
end