class Endorsement < ApplicationRecord
  belongs_to :user_skill, counter_cache: true
  belongs_to :endorser, class_name: "User"

  validates :user_skill_id, presence: true
  validates :endorser_id, presence: true
end
