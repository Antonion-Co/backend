class AddPriceToAppSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :app_services, :price, :decimal, null: false, default: 0.0
  end
end
