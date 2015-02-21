class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.json :metadata, default: {}
      t.timestamps
    end
  end
end
