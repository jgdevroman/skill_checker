class CreateEndorsements < ActiveRecord::Migration[5.2]
  def change
    create_table :endorsements do |t|
      t.integer :endorser_id
      t.references :user_skill, foreign_key: true

      t.timestamps
    end
    add_index :endorsements, :endorser_id
    add_index :endorsements, [:endorser_id, :user_skill_id]
  end
end
