class AddDatetimeColumnToRecords < ActiveRecord::Migration
  def change
    remove_column :records, :datetime, :string
    add_column :records, :datetime, :datetime
  end
end
