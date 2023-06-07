class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
   # 検索方法分岐
   def self.looks(condition, word)
    if condition == "perfect_match"
      @user = User.where('name LIKE?', "#{word}")
    elsif condition == "forward_match"
      @user = User.where('name LIKE?', "#{word}%")
    elsif condition == "backward_match"
      @user = User.where('name LIKE?', "%#{word}")
    elsif condition == "partial_match"
      @user = User.where('name LIKE?', "%#{word}%")
    else
      @user = User.all
    end
  end
      
end
