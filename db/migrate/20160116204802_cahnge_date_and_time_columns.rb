class CahngeDateAndTimeColumns < ActiveRecord::Migration
  def change
      remove_column :records, :date, :string
      add_column :records, :date, :date
      remove_column :records, :time, :string
      add_column :records, :time, :time
  end
end
