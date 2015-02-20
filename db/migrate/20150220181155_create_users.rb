class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :company_name
      t.string :phone_number
      t.string :password_hash
      t.timestamps
    end
  end
end
