class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = User.find(current_user.id)
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end

def is_matching_login_user
  user = User.find(params[:id])
  login_user = current_user
  if (user.id != login_user.id)
    redirect_to user_path(current_user)
  end
end

end
