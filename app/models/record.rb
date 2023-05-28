class Record < ApplicationRecord
    #アソシエーション
    belongs_to :habit

    #バリデーション
    validates :start_time, uniqueness: true

    def is_it_continuous(latest_record, current_record )
        # 継続できているか判断
        # latest_record == 一番最後に保存されたレコード
        # current_record == 保存しようとしているレコード
        if latest_record.start_time == current_record.start_time.yesterday
            # 継続日数を更新
            current_record.continuation = latest_record.continuation + 1
        else
        # アイテムで補填が聞く場合のメソッド
            # diff = (latest_record.start_time - current_record.start_time) / 86400
            # holiday = diff.to_i
            # item = record.items
            # if holiday <= my_item
            # # 休日をアイテムで補填できる場合
            # # アイテムを消費する処理
            # item.update(

            # )
            # # 補填するレコードの作成
            #     holiday.times do |i|
            #     compensation = @habit.records.new(
            #         start_time: latest_record.start_time + i.day
            #         continuation: latest_record.continuation + i
            #     )
            #     conpensation.save
            #     end
                #current_record.continuation = latest_record.continuation + holiday
            # else
            # # アイテムでも補填ができず継続日数をリセット
            #     current_record.continuation = 1
            # end
            current_record.continuation = 1
        end
    end


end
