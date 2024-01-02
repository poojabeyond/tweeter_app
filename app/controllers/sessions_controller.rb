class SessionsController < ApplicationController
    def new
    end

    def create     
        user = User.find_by(email: params[:email])
      
        if user.present? && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to root_path, notice: "You are authenticated user"
        else
          flash[:alert] = "Unauthenticated user"
          render :new
        end
    end

    
    
      

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Logout done'
    end
end