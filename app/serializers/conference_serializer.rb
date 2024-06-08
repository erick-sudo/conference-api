class ConferenceSerializer < ActiveModel::Serializer
  attributes :id, :reference_number, :number, :email, :location, :time, :date, :title, :description, :city, :issues, :resolutions, :recommendations, :expected, :actual
  has_many :participants
  belongs_to :state_department

  def attributes(*args)
    data = super
    data[:attachment_ids] = instance_options[:attachment_ids]
    data
  end
end
