class RecordsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @habit = Habit.find(params[:habit_id])
    current_record = @habit.records.new(record_params)
    #初めての記録ではない場合で、継続中か判断し処理する
    current_record.is_it_continuous(@habit) if 0 < @habit.records.count 
    if current_record.save
      redirect_to request.referer
    else
      render habit_path(@habit)
      # , status: :unprocessable_entity
    end
  end
  private
  def record_params
    params.permit(:start_time,:continuation)
  end
end
