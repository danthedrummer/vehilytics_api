class V1::DeviceRegistrationsController < ApplicationController
  
  respond_to :json
  
  def create
    email = params[:device]['email']
    device_name = params[:device]['device_name']
    password = params[:device]['password']
    password_confirmation = params[:device]['password_confirmation']
    
    if request.format != :json
      render json: {:message => "The request must be json"}, status: 406
      return
    end
    
    if email.nil? or password.nil? or password_confirmation.nil?
      render json: {:message => "The request must contain the device email, password, and password confirmation"}, status: 400
      return
    end
    
    @device_email = Device.find_by_email(email.downcase)

    unless @device_email.nil?
      render json: {:message => "Email address already registered."}, status: 401
      return
    end
    
    @device_name = Device.find_by_device_name(device_name.downcase)
    
    unless @device_name.nil?
      render json: {:message => "Device name already registered."}, status: 401
      return
    end
    
    # create new device, return token
    new_device = Device.new(email: email, device_name: device_name, password: password, password_confirmation: password_confirmation)
    if new_device.save!
      @device = Device.find_by_email(email.downcase)
      render json: {:token => @device.authentication_token}, status: :created
      return
    else
      render json: {:message => "New device not saved."}, status: 400
      return
    end 
  end
  
end
