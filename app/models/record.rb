class Record < ApplicationRecord
    # アソシエーション
    belongs_to :habit

    # validates
    validates :start_time, presence: true
    validates :continuation, presence: true

    def self.is_it_continuou(habit,params)
        latest = habit.records.last
        current = habit.records.new(params)
        # 最後のレコードと作成中のレコードをもらい、
        # 二つの差分により休んだ日数を計算
        diff = (current.start_time - latest.start_time) / 86400
        holiday = diff.to_i - 1
        # アイテムの消費数を計算
        item_stock = []
        item_stock << habit.item - holiday
        if latest.start_time == current.start_time.yesterday
            current.continuation = latest.continuation + 1
        elsif  0 <= item_stock[0]
        # アイテムの消費数より補填できるか判断
            current.continuation = latest.continuation + holiday + 1
            (1..holiday).each do |i|
                habit.records.create(
                  start_time: latest.start_time + i.day,
                  continuation: latest.continuation + i
                )
            end
            # 補填できた場合にhabitのitemを変更したい。
            # その判断材料を追加
            item_stock << "continue"
        end
        current.save
        item_stock
    end



end
