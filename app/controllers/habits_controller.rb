class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_habit, only: %w[show edit update achieve destroy]

  def index
    @habits = @user.habits.all
  end
  
  def show
    @record = Record.new
    challenges = @habit.challenges
    @week_challenges = Array.new(7)
    challenges.each_with_index do |cha, i|
      @week_challenges[i] = cha
    end
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
    item_stock = record_and_challenge_achieve_program
    if @habit.update(item: item_stock)
      flash[:notice] = "記録できました"
      if @habit.challenges.present? && @habit.challenges.last.continuation == 7
        @habit.challenges.destroy_all
        redirect_to habit_challenge_path(@habit)
      else
        redirect_to habit_path(@habit)
      end
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

  def record_and_challenge_achieve_program
    record_date = Record.is_it_continuou(@habit, achieve_params)
    item_stock = record_date.include?("continue") ? record_date[0] : @habit.item
    challenge_result = Challenge.progress_of_the_challenge(@habit, achieve_params) if @habit.challenges.present?
    challenge_result.present? && challenge_result.include?("achieve") ? get_item(item_stock) : item_stock
  end

  def get_item(item_stock)
    item_stock += 2
    item_stock = 4 if 4 < item_stock 
  end


end

# action challenge_button push
# カレンダーを埋めるために各日付に基づいたレコードが必要
# レコードに必要なデータを受け取る処理
# レコードを保存する処理

# 継続中のレコード作成の処理
# レコードが継続しているか判断する処理
## レコードが連続かつ規定数そろった場合の処理
### レコード達成の通知とアイテムの補充
# レコードが途中で途切れた場合の処理
## 該当レコードの削除


# 1週間のカレンダーはビューで条件分岐によって表示、非表示

# habits/show
# <% if @habit.challenges.present? && @habit.challenges.last.start_time == Time.current.yesterday.begining_of_day %>
#   一週間のカレンダーの表示
# <% end %>
# end