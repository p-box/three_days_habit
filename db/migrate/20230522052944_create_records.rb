class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.datetime :start_time
      t.references :habit, null: false, foreign_key: true


      t.timestamps
    end
  end
end
