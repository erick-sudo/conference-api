class StateDepartment < ApplicationRecord
    belongs_to :ministry
    has_many :conferences
    validates :description, length: { maximum: 250 }


    before_validation :truncate_description

    private

    def truncate_description
        max_length = 250 # Replace this with the actual maximum length of the 'description' column
        self.description = description[0, max_length] if description.present?
    end
end