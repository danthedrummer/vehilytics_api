class V1::FirebaseTokensController < ApplicationController
  
  def create
    if current_user == nil
      head(:unauthorized)
      return 
    end
    
    if !params.has_key?("firebase_token")
      head(400)
      return
    end
    
    current_user.firebase_token = params["firebase_token"]
    head(201)
    return
  end
  
end
