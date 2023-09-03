class Article < ApplicationRecord
    has_many :bookmarks
    has_many :bookmarking_users, through: :bookmarks, source: :user
    belongs_to :user, optional: true
    validates :url,  :title, :description,
    presence: true
end
