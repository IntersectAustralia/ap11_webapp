class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :description, :text
    add_column :users, :home_page, :string
    add_column :users, :for_code1, :integer
    add_column :users, :for_code2, :integer
    add_column :users, :for_code3, :integer
  end
end
