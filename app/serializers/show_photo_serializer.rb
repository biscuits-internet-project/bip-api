class ShowPhotoSerializer < Blueprinter::Base
  identifier :id

  fields :id, :label, :source, :user_id, :show_id, :url

end
