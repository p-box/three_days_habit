class RecordsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @habit = Habit.find(params[:habit_id])
    @current_record = @habit.records.new(record_params)

    if @current_record.save
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
