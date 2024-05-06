class UpdateUserTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_login, :datetime
    add_column :users, :status, :boolean, default: true

    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :admin
  end
end
