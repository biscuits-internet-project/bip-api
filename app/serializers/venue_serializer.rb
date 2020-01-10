class VenueSerializer < Blueprinter::Base
  identifier :id

  fields :id, :name, :slug, :city, :state
end