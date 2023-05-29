class Record < ApplicationRecord
    #アソシエーション
    belongs_to :habit

    #バリデーション
    validates :start_time, uniqueness: true

    
    
    
    def is_it_continuous(habit)
        two_records = habit.records.last(2)
        latest = two_records[0]
        puts latest.start_time
        puts self.start_time
        if latest.start_time == self.start_time.yesterday
            puts "true"
            # 継続日数を更新
            self.continuation = latest.continuation + 1
        else
            # 何日休んでいたか求める
            diff = (self.start_time - latest.start_time ) / 86400
            puts diff
            # 日の差分は当日も含まれるのその分引く
            holiday = diff.to_i - 1
            puts holiday
            remaining = habit.item - holiday
            puts remaining
            # 休日を所持しているアイテム数で補填できるか判断
            if 0 <= remaining
                # アイテムを消費する
                habit.update(item: remaining)
                # 休んだ日のレコードを作成する
                (1..remaining).each do |i|
                    no_record_day = habit.records.create(
                        start_time: latest.start_time + i.day,
                        continuation: latest.continuation + i
                    )
                end
            end
        end
    end

end