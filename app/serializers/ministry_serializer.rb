class MinistrySerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :state_departments
end
