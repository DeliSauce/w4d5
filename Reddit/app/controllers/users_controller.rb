class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    if current_user.id == params[:id].to_i
      @user = current_user
      render :show
    else
      redirect_to new_user_url
    end
  end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
