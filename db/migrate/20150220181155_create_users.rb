class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :company
      t.string :name
      t.string :email
      t.string :company_name
      t.string :phone_number
      t.string :password_digest
      t.timestamps
    end
  end
end
