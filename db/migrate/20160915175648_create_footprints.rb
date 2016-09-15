class CreateFootprints < ActiveRecord::Migration[5.0]
  def change
    create_table :footprints do |t|
      t.integer :user_id
      t.integer :application_id

      t.timestamps
    end

    add_index :footprints, :user_id
    add_index :footprints, :application_id
  end
end
