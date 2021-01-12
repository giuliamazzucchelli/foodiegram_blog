class AddNullFalseToFollow < ActiveRecord::Migration[6.0]
  def change
    change_column :follows, :follower_id, :integer, null: :false
    change_column :follows, :followee_id, :integer, null: :false
  end
end
