class CreateTransanctions < ActiveRecord::Migration[6.1]
  def change
    create_table :transanctions do |t|
      t.references :buyer, null: false
      t.references :seller, null: false
      t.references :item, null: false
      t.integer :price
      t.integer :amount

      t.timestamps
    end
    add_foreign_key :transanctions, :users, column: :buyer_id, primary_key: :id
    add_foreign_key :transanctions, :users, column: :seller_id, primary_key: :id
  end
end
