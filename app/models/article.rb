class Article < ApplicationRecord
    has_many :favorites
    belongs_to :user
    validates :url,  :title, :description,
    presence: true
end
