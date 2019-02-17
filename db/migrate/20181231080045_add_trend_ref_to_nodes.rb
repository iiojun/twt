class AddTrendRefToNodes < ActiveRecord::Migration[5.2]
  def change
    add_reference :nodes, :trend, foreign_key: true
  end
end
