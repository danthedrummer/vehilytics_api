class V1::UserRegistrationsController < Devise::RegistrationsController
  
  respond_to :json
  
  def create
    email = params[:user]['email']
    password = params[:user]['password']
    password_confirmation = params[:user]['password_confirmation']
    
    if request.format != :json
      render json: {:message => "The request must be json"}, status: 406
      return
    end
    
    if email.nil? or password.nil? or password_confirmation.nil?
      render json: {:message => "The request must contain the user email, password, and password confirmation"}, status: 400
      return
    end
    
    @useremail = User.find_by_email(email.downcase)

    unless @useremail.nil?
      render json: {:message => "Email address already registered."}, status: 401
      return
    end
    
    # create new user, return token
    new_user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    if new_user.save
      @user = User.find_by_email(email.downcase)
      render json: {:token => @user.authentication_token}, status: :created
      return
    else
      render json: {:message => "New user not saved."}, status: 400
      return
    end 
  end
  
end
