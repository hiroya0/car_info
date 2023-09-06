class BookmarksController < ApplicationController
    def show
        @bookmark = Bookmark.find(params[:id])
    end
    
    def create
        bookmark = current_user.bookmarks.new(article: Article.find_by(article_id: params[:article_id]))
        unless bookmark.save
            logger.info "Failed to save bookmark due to: #{bookmark.errors.full_messages.join(", ")}"
        end
        flash[:success] = "ブックマーク登録しました"
        redirect_to article_path(params[:article_id])
    end
      
    def destroy
        bookmark = current_user.bookmarks.find_by(article_id: params[:article_id])
    
        if bookmark.present?
            bookmark.destroy
            redirect_to article_path(params[:article_id])
        else
            flash[:alert] = "ブックマークが存在しません"
            redirect_to root_path #詳細画面に遷移させるのが妥当か
        end
    end
    
end
