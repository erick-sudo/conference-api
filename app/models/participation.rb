class Participation < ApplicationRecord
    belongs_to :conference
    belongs_to :participant
end
