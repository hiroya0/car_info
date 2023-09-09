class BookmarksController < ApplicationController
    def show
        @bookmark = Bookmark.find(params[:id])
    end
    
    def index
        @bookmarks = current_user.bookmarks
    end

    def create
        bookmark = current_user.bookmarks.new(article: Article.find_by(article_id: params[:article_id]))
        if bookmark.save
            flash[:success] = "ブックマーク登録しました"
        else
            flash[:alert] = "ブックマークに失敗しました"
        end
        redirect_to article_path(params[:article_id])
    end
      
    def destroy
        bookmark = current_user.bookmarks.find_by(id: params[:id])
        if bookmark.present?
            bookmark.destroy
            redirect_to bookmarks_path
        else
            flash[:alert] = "ブックマークが存在しません"
            redirect_to root_path 
        end
    end
    
end
