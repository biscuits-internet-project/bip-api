class AuthorSerializer < Blueprinter::Base
  identifier :id

  fields :id, :name, :slug
end
