class CreateBankData < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_data do |t|
      t.string :bank_name
      t.string :bank_number
      t.string :agency_number
      t.string :account_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
