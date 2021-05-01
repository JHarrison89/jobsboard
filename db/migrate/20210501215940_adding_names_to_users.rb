class AddingNamesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :last_name
  end
end
