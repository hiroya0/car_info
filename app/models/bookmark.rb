class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :user_id, uniqueness: { message: "あなたは既にこの記事をブックマークしています" }
end
