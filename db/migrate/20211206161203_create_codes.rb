class CreateCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :codes do |t|
      t.string :type
      t.integer :creditAmount
      t.string :status

      t.timestamps
    end
  end
end
