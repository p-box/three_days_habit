class Record < ApplicationRecord
    #アソシエーション
    belongs_to :habit

    #バリデーション
    validates :start_time, uniqueness: true

    def self.is_it_continuous(habit,record_params)
        latest = habit.records.last
        current = habit.records.new(record_params)
        diff = (current.start_time - latest.start_time) / 86400
        holiday = diff.to_i - 1
        remaining = habit.item - holiday
        if latest.start_time == current.start_time.yesterday
          current.continuation = latest.continuation + 1
        elsif  0 <= remaining
          current.continuation = latest.continuation + holiday + 1
          (1..holiday).each do |i|
            habit.records.create(
              start_time: latest.start_time + i.day,
              continuation: latest.continuation + i
            )
          end
        end
        puts current.continuation
        return current
    end
    
    
    
    # def is_it_continuous(habit)
    #     two_records = habit.records.last(2)
    #     latest = two_records[0]
    #     puts latest.start_time
    #     puts self.start_time
    #     if latest.start_time == self.start_time.yesterday
    #         # 継続日数を更新
    #         self.continuation = latest.continuation + 1
    #     else
    #         # 何日休んでいたか求める
    #         diff = (self.start_time - latest.start_time ) / 86400
    #         # 日の差分は当日も含まれるのその分引く
    #         holiday = diff.to_i - 1
    #         remaining = habit.item - holiday
    #         # 休日を所持しているアイテム数で補填できるか判断
    #         if 0 <= remaining
    #             # アイテムを消費する
    #             habit.item =  remaining
    #             habit.save
    #             # 休んだ日のレコードを作成する
    #             (1..holiday).each do |i|
    #                 habit.records.create(
    #                     start_time: latest.start_time + i.day,
    #                     continuation: latest.continuation + i
    #                 )
    #             end
    #         end
    #     end
    # end

end
# 問題点
# レコードの保存される順番が前後しているから日付のカウントが誤作動している
# アイテムの消費をこのメソッド内で更新すると、curennt_recordが保存されてしまう
# 同じ日を保存すると、最新のレコードの場所が同じになりおかしくなる
