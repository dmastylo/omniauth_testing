class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id.:format
  def update
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, :bypass => true)
      redirect_to @user, notice: 'Your profile was successfully updated.'
    else
      render 'edit'
    end
  end

  # GET/PATCH /users/:id/finish_signup
  # This is an extra signup page for additional details 
  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    @user.destroy
    redirect_to root_url
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [:name, :email]
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

end
