class VenueSerializer < Blueprinter::Base
  identifier :id

  fields :id, :name, :slug, :city, :state

  view :details do
    field :times_played
    field :first_time_played, datetime_format: "%Y-%m-%d"
    field :last_time_played, datetime_format: "%Y-%m-%d"
  end
end