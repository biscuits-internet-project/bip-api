class UserCreate
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(params)
    # auto-confirm since this is admin only
    user.confirmed_at = DateTime.now

    if user.save
      return user
    else
      errors.merge!(user.errors)
    end
  end

end