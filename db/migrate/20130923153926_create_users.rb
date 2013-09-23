class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
