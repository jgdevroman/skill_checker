class AddIndexToUserSkillsName < ActiveRecord::Migration[5.2]
  def change
    add_index(:user_skills, [:name, :user_id])
  end
end
