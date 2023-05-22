class Record < ApplicationRecord
    #アソシエーション
    belongs_to :habit

    #バリデーション
    validates :start_time, uniqueness: true

    
end
