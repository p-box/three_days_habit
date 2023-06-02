class AchieveForm
    include ActiveModel::Model

    attr_accessor :start_time, :continuation
    
    validates :start_time, presence: true
    validates :continuation, presence: true
    
    def initialize(attributes = nil, habit: Habit.new)
        @habit = habit
        attributes ||= default_attributes
        super(attributes)
    end
    
    def save
        return if invalid?

        ActiveRecord::Base.transaction do
            record_date = Record.is_it_continuou(@habit, record_params)
            item_stock = record_date.include?("continue") ? record_date[0] : @habit.item
            challenge_result = Challenge.progress_of_the_challenge(@habit, record_params) if @habit.challenges.present?
            challenge_result.include?("achieve") ? get_item(item_stock) : item_stock
            @habit.update(item: item_stock)
        end

        private
        attr_reader :record

        def default_attributes
            {
                start_time: record.start_time,
                continuation: record.continuation

            }
        end

        def get_item(item_stock)
            item_stock += 2
            item_stock = 4 if 4 < item_stock 
        end
    end

end