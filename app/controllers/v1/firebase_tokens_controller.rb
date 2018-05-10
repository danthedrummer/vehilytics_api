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
    current_user.save!

    head(201)
  end
  
  def destroy
    if current_user != nil
      head(:unauthorized)
      return
    end
    
    current_user.firebase_token = nil
    current_user.save!
    
    head(200)
  end
  
end
