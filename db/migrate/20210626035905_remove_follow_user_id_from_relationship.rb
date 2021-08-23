class RemoveFollowUserIdFromRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :follow_user_id, :integer
  end
end
