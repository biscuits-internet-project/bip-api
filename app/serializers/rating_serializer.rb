class RatingSerializer < Blueprinter::Base

  fields :rateable_id, :rateable_type, :value

end
