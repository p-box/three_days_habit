class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.datetime :start_time
      t.integer  :continuation
      t.references :habit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
