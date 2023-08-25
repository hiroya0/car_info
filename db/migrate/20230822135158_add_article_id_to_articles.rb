class AddArticleIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :article_id, :integer
  end
end
