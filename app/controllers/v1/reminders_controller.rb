class V1::RemindersController < ApplicationController
  
  def index
    @reminders = Reminder.all
    render json: @reminders, status: :ok
  end
end
