class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.references :member, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
