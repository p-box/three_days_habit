class Habit < ApplicationRecord

    validates :name, presence: true, length: { maximum: 12 }

    belongs_to :user
end
