class Habit < ApplicationRecord
    #アソシエーション
    belongs_to :user

    #バリデーション
    validates :name, presence: true, length: { maximum: 12 }

    mount_uploader :habit_image, ImageUploader


end
