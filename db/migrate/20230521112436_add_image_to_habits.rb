class AddImageToHabits < ActiveRecord::Migration[7.0]
  def up 
    add_column :habits, :habit_image, :string
    
  end
end
