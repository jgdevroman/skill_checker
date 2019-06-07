
class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill_tag
  has_many :endorsements, dependent: :destroy
  has_many :endorsers, through: :endorsements, source: :endorser
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: {scope: :user_id}, length: {maximum: 50}
  validate :same_name_with_skill_tag

  def same_name_with_skill_tag
    if name != skill_tag.name
      errors.add(:name, "Must be the same as the Skill Tag!")
    end
  end 
  
  default_scope -> {order(endorsements_count: :desc)}
  # default_scope -> {left_joins(:endorsements).group(:id).order('COUNT(endorsements.id) ASC')}
  
  #Checks if the skill is endorsed by a specific user
  def endorsed?(other_user)
    endorsers.include?(other_user)
  end

end