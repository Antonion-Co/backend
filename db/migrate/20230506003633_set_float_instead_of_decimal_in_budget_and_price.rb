class SetFloatInsteadOfDecimalInBudgetAndPrice < ActiveRecord::Migration[7.0]
  def change
    change_column :app_services, :price, :float, null: false, default: 0.0
    change_column :users, :budget, :float, null: false, default: 0.0
  end
end
