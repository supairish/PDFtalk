class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :title
      t.string :total

      t.timestamps
    end
  end
end
