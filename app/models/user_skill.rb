class UserSkill < ApplicationRecord
  belongs_to :user
  default_scope -> {order(endorsement: :desc)}
  after_initialize :set_defaults

  def set_defaults
    self.endorsement = 0 if self.endorsement.nil?
  end


  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {scope: :user_id}, length: {maximum: 50}
  validates :endorsement, presence: true, numericality: {greater_than: -1, less_than_or_equal_to: 99}
end