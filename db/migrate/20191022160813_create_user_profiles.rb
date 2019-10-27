class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.date :birthdate
      t.integer :cpf
      t.integer :rg
      t.string :est_civil
      t.string :secretary
      t.string :entity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
