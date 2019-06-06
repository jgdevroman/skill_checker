class RemoveEndorsementsFromUserSkills < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_skills, :endorsement, :integer
  end
end
