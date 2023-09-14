class AddUrlToImageToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :urlToImage, :string
  end
end
