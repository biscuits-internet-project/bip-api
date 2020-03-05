class UserSerializer < Blueprinter::Base
  fields :id, :first_name, :last_name, :email, :username, :avatar_url

  view :public do
    excludes :id, :first_name, :last_name, :email
  end

end