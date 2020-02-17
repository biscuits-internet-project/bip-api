class VenueSerializer < Blueprinter::Base
  identifier :id

  fields :id, :name, :slug, :city, :state

  view :details do
    field :times_played
    association :first_played_show, blueprint: ShowSerializer
    association :last_played_show, blueprint: ShowSerializer
  end
end