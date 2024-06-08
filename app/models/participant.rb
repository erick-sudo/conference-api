class Participant < ApplicationRecord
    has_many :participations
    has_many :conferences, through: :participations
end
