class AddContinuationToRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :records, :continuation, :integer
  end
end
