class SkillTag < ApplicationRecord
    has_many :user_skills
    has_many :users, through: :user_skills, source: :user

    validates :name, uniqueness: true

end
