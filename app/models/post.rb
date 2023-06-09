class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy

    validates :body, presence: true, length: { maximum: 300 }

    mount_uploader :post_image, ImageUploader


    def favorited?(user)
        favorites.where(user_id: user.id).exists?
    end

    def favorited_count
        favorites.count
    end
    

end
