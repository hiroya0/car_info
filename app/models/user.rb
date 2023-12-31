class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :bookmarks
         has_many :bookmarked_articles, through: :bookmarks, source: :article
         has_many :articles
end
