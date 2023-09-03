class BookmarksController < ApplicationController
    def create
        bookmark = current_user.bookmarks.new(article_id: params[:article_id])
        bookmark.save
        flash[:success] = "ブックマーク登録しました"
        redirect_to article_path(params[:article_id])
    end
      
    def destroy
        bookmark = current_user.bookmarks.find_by(article_id: params[:article_id])
    
        if bookmark.present?
            bookmark.destroy
            redirect_to article_path(params[:article_id])
        else
            # エラーメッセージをフラッシュにセットするなど、適切な処理を行う
            flash[:alert] = "ブックマークが存在しません"
            redirect_to root_path # または適切なパスにリダイレクト
        end
    end
end
