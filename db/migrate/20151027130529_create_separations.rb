class CreateSeparations < ActiveRecord::Migration
  def change
    create_table :separations do |t|
      t.integer :group_id
      t.integer :person1_id
      t.integer :person2_id
      t.timestamps null: false
    end
  end
end
