class CreateStateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :state_departments do |t|
      t.string :name
      t.string :description
      t.string :ministry_name
      t.integer :ministry_id

      t.timestamps
    end
  end
end
