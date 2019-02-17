class CreateTrends < ActiveRecord::Migration[5.2]
  def change
    create_table :trends do |t|
      t.string :label
      t.date :collected

      t.timestamps
    end
  end
end
