class AddSkillTagIdToUserSkill < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_skills, :skill_tag, foreign_key: true
  end
end
