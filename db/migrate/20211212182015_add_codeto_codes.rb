class AddCodetoCodes < ActiveRecord::Migration[6.1]
  def change
    add_column :codes, :code, :string
  end
end
