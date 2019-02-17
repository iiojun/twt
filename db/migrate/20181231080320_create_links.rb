class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.float :corr

      t.timestamps
    end
  end
end
