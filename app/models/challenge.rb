class Challenge < ApplicationRecord
    
    #アソシエーション
    belongs_to :habit

    #validates
    validates :start_time, presence: true
    validates :continuation, presence: true


    def self.progress_of_the_challenge(habit,params)
        latest = habit.challenges.last
        current = habit.challenges.new(params)
        result = "ongoing or failed"
        if  latest.start_time == current.start_time.yesterday && latest.continuation == 6
        current.continuation = 7
        current.save
        result = "achieve"
        elsif  latest.start_time == current.start_time.yesterday
        current.continuation = latest.continuation + 1
        current.save
        else
        habit.challenges.each{|i| i.destroy }
        end
        result
    end
end
