class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :nationality, :id_number, :address, :city
  has_many :conferences
end
