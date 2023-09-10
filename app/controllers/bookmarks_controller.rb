class BookmarksController < ApplicationController
    def show
        @bookmark = Bookmark.find(params[:id])
    end
    
    def index
        @bookmarks = current_user.bookmarks
    end

    def create
        # 関連するArticleの存在を確認
        article = Article.find_by(article_id: params[:article_id])
        if article.nil?
            flash[:alert] = "関連する記事が存在しません"
            redirect_to root_path and return
        end
        
        bookmark = current_user.bookmarks.new(article: article)
        if bookmark.save
            flash[:success] = "ブックマーク登録しました"
        else
            flash[:alert] = "ブックマークに失敗しました: #{bookmark.errors.full_messages.join(', ')}"
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
