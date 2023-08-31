class Article < ApplicationRecord
    has_many :favorites
    belongs_to :user, optional: true
    validates :url,  :title, :description,
    presence: true
end
