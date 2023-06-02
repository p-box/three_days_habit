class Habit < ApplicationRecord
    #アソシエーション
    belongs_to :user
    has_many :records, dependent: :destroy
    has_many :challenges, dependent: :destroy

    #バリデーション
    validates :name, presence: true, length: { maximum: 12 }
    validates :item, presence: true, length: {in: 0..4}

    mount_uploader :habit_image, ImageUploader

    
    

end
