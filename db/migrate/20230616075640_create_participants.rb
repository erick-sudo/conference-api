class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :id_number
      t.string :address
      t.string :city
      t.string :nationality

      t.timestamps
    end
  end
end
