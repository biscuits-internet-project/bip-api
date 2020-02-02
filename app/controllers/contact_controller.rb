class ContactController < ApplicationController
  skip_before_action :authenticate_request

  # POST /contact 
  def create
    command = ContactSend.call(params)
  
    if command.success?
      render json: {}, status: :ok
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end
end
