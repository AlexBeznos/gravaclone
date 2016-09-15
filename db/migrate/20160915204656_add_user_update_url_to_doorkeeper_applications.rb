class AddUserUpdateUrlToDoorkeeperApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :oauth_applications, :user_update_url, :string
  end
end
