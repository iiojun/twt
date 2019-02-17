class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :word
      t.float :freq

      t.timestamps
    end
  end
end
