class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :datetime
      t.integer :summa
      t.string :desc
      t.string :data
      t.string :time
      t.string :label
      t.integer :status

      t.timestamps
    end
  end
end
