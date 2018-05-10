class V1::FirebaseTokensController < ApplicationController
  
  def create
    if current_user == nil
      head(:unauthorized)
      return 
    end
    
    if !params.has_key?("firebase_token") || params["firebase_token"] == nil
      head(400)
      return
    end
    
    current_user.firebase_token = params["firebase_token"]
    render json: { "message": "Storing token: #{current_user.firebase_token}" }, status: :created
    return
  end
  
end
