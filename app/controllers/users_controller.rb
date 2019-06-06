class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @user_skills = @user.user_skills.includes(:endorsements, :endorsers)
    @user_skill = @user.user_skills.build if logged_in
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      log_in @user
      flash[:success] = "Welcome to Skill Checker!"
      redirect_to @user
    else
      render "new"
    end
  end

  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:danger] = "You can't change other user's information!"
        redirect_to(root_url) 
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
