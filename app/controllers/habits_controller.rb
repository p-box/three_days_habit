class HabitsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @habits = @user.habits.all
  end

  def new
    @user = current_user
    @habit = @user.habits.new
  end
  
  def create
    @user = current_user
    @habit = @user.habits.new(habit_params)
    if @habit.save
      flash[:notice] = "作成しました"
      redirect_to habits_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    puts params
    puts "どれみ"
    @habit = Habit.find(params)
  end
  
  def upadate
    @habit = Habit.find(params)
    if @habit.update(habit_params)
      flash[:notice] = "編集しました"
      redirect_to habits_index_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
  end

  private
  def habit_params
    params.require(:habit).permit(:name, :habit_image)
  end
end
