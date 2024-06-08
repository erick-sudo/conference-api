class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :is_admin
end