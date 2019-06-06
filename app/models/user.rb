class User < ApplicationRecord
    has_many :user_skills, dependent: :destroy
    has_many :endorsements, foreign_key: "endorser_id", dependent: :destroy
    default_scope -> {order(:id)}
    has_many :endorsing, through: :endorsements, source: :user_skill

    before_save {email.downcase!}

    validates :name, presence: true, length: {maximum: 50}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #endorse a skill from another user
    def endorse(other_user_skill)
        if !other_user_skill
            return nil
        end
        if other_user_skill.endorsed?(self) || self.user_skills.include?(other_user_skill)
            return nil
        end
        endorsing << other_user_skill
    end

end
