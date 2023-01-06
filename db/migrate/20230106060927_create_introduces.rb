class CreateIntroduces < ActiveRecord::Migration[6.1]
  def change
    create_table :introduces do |t|
      t.references :introduce_from_user, foreign_key: true
      t.references :introduce_to_user, foreign_key: true
      t.text :body
      t.timestamps
    end
  end
end
