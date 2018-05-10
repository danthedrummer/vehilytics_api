class V1::UserSessionsController < ApplicationController
  
  # Checking that the current token is valid
  def show
    current_user ? head(:ok) : head(:unauthorized)
  end
  
  # Signing in
  def create
    user = User.where(email: params[:email]).first
    
    if params.has_key?("firebase_token")
      user.firebase_token = params["firebase_token"]
      user.save!
    end
    
    if user&.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
  
  # Signing out
  def destroy
    if current_user == nil
      head(:unauthorized)
      return
    end
    
    current_user&.authentication_token = nil
    current_user.firebase_token = nil
    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
  
end