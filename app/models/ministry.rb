class Ministry < ApplicationRecord
    has_many :state_departments
    has_many :conferences, through: :state_departments

    validates :description, length: { maximum: 250 }

    def conferences
        state_departments.map { |department| department.conferences }.flatten
    end

    before_validation :truncate_description

    private

    def truncate_description
        max_length = 250 # Replace this with the actual maximum length of the 'description' column
        self.description = description[0, max_length] if description.present?
    end
end
