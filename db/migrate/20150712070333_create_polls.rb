class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :user, index: true, foreign_key: true
      t.string :question
      t.string :token
      t.boolean :multi, default: false
      t.boolean :public, default: false

      t.timestamps null: false
    end
  end
end
