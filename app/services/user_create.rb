class UserCreate
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    avatar = params[:avatar]
    user = User.new(params.except(:avatar))
    # auto-confirm since this is admin only
    user.confirmed_at = DateTime.now
  
    if user.save
      if avatar.present?
        user.avatar.attach(avatar)
      end
      return user
    else
      errors.merge!(user.errors)
    end
  end

end