class ShowCreate
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    show = Show.new(params)
    show.band_id = '4cccc925-8cd3-40a3-9ec1-5b9fd14dd040'

    if show.save
      return show
    else
      errors.merge!(show.errors)
    end
  end

end