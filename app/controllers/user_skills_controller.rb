class UserSkillsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        # puts user_skill_params[:user_skill]
        @user = User.find(params[:user_skill][:user_id])
        @user_skills = @user.user_skills
        @user_skill = @user_skills.build(name: params[:user_skill][:name])
        if @user_skill.save
            flash[:success] = "Skill Added!"
            redirect_to user_path(@user)
        else
            render "users/show"
        end

    end

    def destroy
        @user_skill.destroy
        flash[:success] = "Skill deleted!"
        redirect_to user_path(current_user)
    end

    private 
        def user_skill_params
            params.require(:user_skill).permit(:name, :user_id)
        end

        def correct_user
            @user_skill = current_user.user_skills.find_by(id: params[:id])
            redirect_to root_url if @user_skill.nil?
        end
end