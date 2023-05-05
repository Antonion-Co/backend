class CreateAppServices < ActiveRecord::Migration[7.0]
  def change
    create_table :app_services do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
