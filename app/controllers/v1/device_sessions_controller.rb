class V1::DeviceSessionsController < ApplicationController
  
  # Checking that the current token is valid
  def show
    current_device ? head(:ok) : head(:unauthorized)
  end
  
  def create
    device = Device.where(email: params[:email]).first
    
    if device&.valid_password?(params[:password])
      render json: device.as_json(only: [:device_name, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
  
  def destroy
    current_device&.authentication_token = nil
    if current_device.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end
