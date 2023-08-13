class Article < ApplicationRecord
    has_many :favorites
    has_many :users
    validates :url, :image_url, :title, :description,
    presence: true
end
