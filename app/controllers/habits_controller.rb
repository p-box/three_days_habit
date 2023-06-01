class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_habit, only: %w[show edit update achieve destroy]

  def index
    @habits = @user.habits.all
  end
  
  def show
    @record = Record.new
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
  end
  
  def update
    if @habit.update(habit_params)
      flash[:notice] = "編集しました"
      redirect_to habit_path(@habit)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def achieve
    record_date = Record.is_it_continuou(@habit,achieve_params)
    item_stock = record_date.include?("true") ? record_date[0] : @habit.item
    if @habit.update(item: item_stock)
      flash[:notice] = "記録できました"
      redirect_to habit_path(@habit)
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  def destroy
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

  def achieve_params
    params.require(:record).permit(:start_time, :continuation)
  end

  def set_user
    @user = current_user
  end

  def set_habit
    @habit = @user.habits.find(params[:id])
  end


end
