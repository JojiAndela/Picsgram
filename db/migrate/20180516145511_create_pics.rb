class CreatePics < ActiveRecord::Migration[5.1]
  def change
    create_table :pics do |t|
      t.text :caption
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
