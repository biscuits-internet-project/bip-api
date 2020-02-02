class ContactSend
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    ContactMailer.send_contact(params[:email], params[:name], params[:message]).deliver
  end

end