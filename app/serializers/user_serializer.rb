class UserSerializer < Blueprinter::Base
  fields :id, :first_name, :last_name, :email, :username

  view :public do
    excludes :id, :first_name, :last_name, :email
    field :username
  end

end