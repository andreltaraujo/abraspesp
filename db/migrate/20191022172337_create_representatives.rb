class CreateRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :representatives do |t|
      t.string :code
      t.string :cpf
      t.string :first_name
      t.string :last_name
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
