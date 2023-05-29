class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @habits = @user.habits.all
  end
  
  def show
    @habit = @user.habits.find(params[:id])
  end

  def new
    @habit = @user.habits.new
  end
  
  def create
    @habit = @user.habits.new(habit_params)
    if @habit.save
      flash[:notice] = "作成しました"
      redirect_to habit_path(@habit)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @habit = @user.habits.find(params[:id])
  end
  
  def update
    @habit = @user.habits.find(params[:id])
    if @habit.update(habit_params)
      flash[:notice] = "編集しました"
      redirect_to habit_path(@habit)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @user = current_user
    @habit = @user.habits.find(params[:id])
    if @habit.destroy
      flash[:notice] = "削除しました"
      redirect_to habit_path(@habit)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def habit_params
    params.require(:habit).permit(:name, :habit_image, :item)
  end

  def set_user
    @user = current_user
  end
end
