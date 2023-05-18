class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"  
    # belongs_to :userだとわからなくなる。なのでそれぞれを名前で指定。
    # けれど、このままだとfollower,followedテーブルを探しにいってしまう。
    # それをclass_name: "User"で探しに行くテーブルを指定して防ぐ。
end
