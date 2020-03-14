class ShowCreate
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    show = Show.new(params)
    show.band = Band.find("the-disco-biscuits")

    if show.save
      return show
    else
      errors.merge!(show.errors)
    end
  end

end