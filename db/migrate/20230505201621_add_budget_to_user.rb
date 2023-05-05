class AddBudgetToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :budget, :decimal, null: false, default: 0.0
  end
end
