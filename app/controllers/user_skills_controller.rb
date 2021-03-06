class UserSkillsController < ApplicationController
    before_action :logged_in_user, only: [:get, :create, :destroy]
    before_action :correct_user, only: :destroy

    def index
        redirect_back_or(users_path)        
    end

    def create
        # puts user_skill_params[:user_skill]
        @user = User.find(params[:user_skill][:user_id])
        @user_skills = @user.user_skills

        name = params[:user_skill][:name]

        skill_tag = find_skill_tag(name)
        @user_skill = @user_skills.build(name: name, skill_tag_id: skill_tag.id)
        
        if @user_skill.save
            current_user.endorse(@user_skill) if !current_user?(@user)
            flash[:success] = "Skill added!"
            redirect_back_or(user_path(@user))
        else
            @user_skill.name = ""
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

        def find_skill_tag(name)
            skill_tag = SkillTag.find_by(name: name)
            if !skill_tag
                skill_tag = SkillTag.create!(name: name)
            end
            return skill_tag
        end

end
