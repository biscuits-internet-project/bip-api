class VenueSerializer < Blueprinter::Base
  identifier :id

  fields :id, :name, :slug, :city, :state, :times_played

  view :details do
    association :first_played_show, blueprint: ShowSerializer
    association :last_played_show, blueprint: ShowSerializer
  end
end