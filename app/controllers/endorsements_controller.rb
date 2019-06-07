class EndorsementsController < ApplicationController
    before_action :logged_in_user
    before_action :not_self

    def create
        user_skill = UserSkill.find(params[:user_skill_id])
        current_user.endorse(user_skill)
        flash[:success] = "Skill endorsed!"
        redirect_back_or(user_path(user_skill.user)) 
    end

    private
        def not_self
            user = UserSkill.find(params[:user_skill_id]).user
            redirect_to root_url if current_user?(user)
        end
end
