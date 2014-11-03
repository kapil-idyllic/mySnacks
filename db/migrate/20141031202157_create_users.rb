class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email, null: false
      t.text :username, null: false
      t.text :password, null: false
      t.text :device_id, null: false
      t.timestamps
    end
    add_index :users, [:email], :unique => true
  end
end
