class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
