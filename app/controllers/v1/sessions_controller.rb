class V1::SessionsController < ApplicationController
  
  # Checking that the current token is valid
  def show
    current_user ? head(:ok) : head(:unauthorized)
  end
  
  # Signing in
  def create
    user = User.where(email: params[:email]).first
    
    if user&.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
  
  # Signing out
  def destroy
    current_user&.authentication_token = nil
    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
  
end