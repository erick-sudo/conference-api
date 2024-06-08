class Conference < ApplicationRecord
    has_many :participations
    has_many :participants, through: :participations

    has_many_attached :files
    has_one_attached :poster
    belongs_to :state_department

    validates :description, length: { maximum: 250 }
    validates :issues, length: { maximum: 250 }
    validates :resolutions, length: { maximum: 250 }
    validates :recommendations, length: { maximum: 250 }

    before_validation :truncate_description
    before_validation :truncate_issues
    before_validation :truncate_resolutions
    before_validation :truncate_recommendations

    def get_start_date
        Date.parse(self.date.split(' ').first)
    end

    def get_end_date
        Date.parse(self.date.split(' ').last)
    end

    private

    def truncate_description
        self.description = description[0, 250] if description.present?
    end

    def truncate_issues
        self.issues = issues[0, 250] if issues.present?
    end

    def truncate_resolutions
        self.resolutions = resolutions[0, 250] if resolutions.present?
    end

    def truncate_recommendations
        self.recommendations = recommendations[0, 250] if recommendations.present?
    end
end
