class RemovetypefromCodes < ActiveRecord::Migration[6.1]
  def change
    remove_column :codes, :type, :string
  end
end
