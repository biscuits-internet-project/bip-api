class AnnotationSerializer < Blueprinter::Base
  identifier :id

  fields :id, :desc

  view :setlist do
    fields :desc
  end
end