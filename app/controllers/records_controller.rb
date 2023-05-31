class RecordsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @habit = Habit.find(params[:habit_id])
    record = @habit.records.present? ? Record.is_it_continuous(@habit, record_params) : @habit.records.new(record_params)
    # current_record = @habit.records.new(record_params)
    # #初めての記録ではない場合で、継続中か判断し処理する
    # current_record.is_it_continuous(@habit) if @habit.records.present?
    @habit.update(item: 5)
    if record.save
      redirect_to request.referer
    else
      render "habits/show", status: :unprocessable_entity
    end
  end
  private
  def record_params
    params.permit(:start_time, :continuation)
  end
end
# 継続中か判断
## 継続中の場合
### 継続日数を更新する処理

## 継続がとぎれた場合
### 継続の途切れを回復できるか判断する処理
#### 回復できた場合
##### 継続の途切れを回復させる処理
#### 回復できない場合
##### 継続を途切れさせる処理


