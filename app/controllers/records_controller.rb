class RecordsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    puts "ドレミ"
    puts params
    @habit = Habit.find(params[:habit_id])
    @record = @habit.records.new(record_params)
    
    if @record.save
      redirect_to request.referer
    else
      render habit_path(@habit), status: :unprocessable_entity
    end
  end

  private
  def record_params
    params.permit(:start_time)
  end
end
