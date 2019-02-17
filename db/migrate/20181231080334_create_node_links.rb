class CreateNodeLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :node_links do |t|
      t.references :node, foreign_key: true
      t.references :link, foreign_key: true

      t.timestamps
    end
  end
end
