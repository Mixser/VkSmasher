class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.user_id :integer
      t.firstName :string
      t.lastName :string

      t.timestamps
    end
  end
end
