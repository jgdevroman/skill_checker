class UserSkill < ApplicationRecord
  belongs_to :user
  has_many :endorsements, dependent: :destroy
  has_many :endorsers, through: :endorsements, source: :endorser
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {scope: :user_id}, length: {maximum: 50}
  
  default_scope -> {order(endorsements_count: :desc)}
  # default_scope -> {left_joins(:endorsements).group(:id).order('COUNT(endorsements.id) ASC')}
  
  #Checks if the skill is endorsed by a specific user
  def endorsed?(other_user)
    endorsers.include?(other_user)
  end

end