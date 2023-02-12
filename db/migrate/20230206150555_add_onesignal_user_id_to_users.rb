class AddOnesignalUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :onesignal_user_id, :string
  end
end
