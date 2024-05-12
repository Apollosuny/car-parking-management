class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    # Add the role column with enum values
    add_column :users, :role, :integer, default: 0
  end
end
