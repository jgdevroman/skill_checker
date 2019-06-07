class SkillTagsController < ApplicationController
  def show
    store_location
    @skill_tag = SkillTag.find(params[:id])
    @user_skills = @skill_tag.user_skills.includes(:endorsers, :user)
    @experts = @skill_tag.users
    @user_skill = @user_skills.build
    @added = added?(@skill_tag)
  end

  private 
    def added?(skill_tag)
      if !logged_in
        return false
      end
      if current_user.user_skills.find_by(skill_tag_id: skill_tag.id)
          true
      else
          false
      end
    end
end
