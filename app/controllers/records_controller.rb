class RecordsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @habit = Habit.find(params[:habit_id])
    record = @habit.records.new(record_params)
    if record.save
      redirect_to request.referer
    else
      render "habits/show", status: :unprocessable_entity
    end
  end

  private

  def record_params
    params.require(:record).permit(:start_time, :continuation)
  end
end
