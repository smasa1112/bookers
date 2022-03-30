class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :prefecture_code, :integer
  end
end
