class CreateIntroduces < ActiveRecord::Migration[6.1]
  def change
    create_table :introduces do |t|
      t.references :introduce_from_user, foreign_key: { to_table: :users }
      t.references :introduce_to_user, foreign_key: { to_table: :users}
      t.text :body
      t.timestamps
      
      t.index [:introduce_from_user_id, :introduce_to_user_id], unique: true, name: 'introduce_unique_index'
    end
  end
end
