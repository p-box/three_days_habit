class Post < ApplicationRecord
    belongs_to :user
    has_many :fovarites, dependent: :destroy

    validates :body, presence: true, length: { maximum: 300 }
end
