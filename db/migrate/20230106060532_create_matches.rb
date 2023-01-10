class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :matching_status, default: 0, null: false
      t.string :room_comment
      t.string :game_name
      t.timestamps
    end
  end
end
