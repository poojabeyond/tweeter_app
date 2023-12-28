class PasswordResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
        PasswordMailer.with(user: @user).reset.deliver_now   
    end

    redirect_to root_path notice: "If an account with that email was found, will sent reset link to your mail"
    
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password got reset successfully, you can sign in now"
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end