class CreateConferences < ActiveRecord::Migration[7.0]
  def change
    create_table :conferences do |t|
      t.string :reference_number
      t.string :number
      t.string :email
      t.string :location
      t.string :time
      t.string :date
      t.string :title
      t.string :description
      t.integer :expected
      t.integer :actual
      t.string :city
      t.string :issues
      t.string :resolutions
      t.string :recommendations
      t.integer :state_department_id

      t.timestamps
    end
  end
end
