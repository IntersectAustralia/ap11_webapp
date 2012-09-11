class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :description, :text
    add_column :users, :home_page, :string
    add_column :users, :for_code1, :string
    add_column :users, :for_code2, :string
    add_column :users, :for_code3, :string
  end
end
