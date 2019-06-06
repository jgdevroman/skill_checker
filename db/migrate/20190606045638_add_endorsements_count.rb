class AddEndorsementsCount < ActiveRecord::Migration[5.2]
  def change
    add_column :user_skills, :endorsements_count, :integer, default: 0
  end
end
