class RemoveEndorsersCount < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_skills, :endorsers_count, :integer
  end
end
