class UserSerializer < Blueprinter::Base
  identifier :id

  fields :id, :first_name, :last_name, :email
end