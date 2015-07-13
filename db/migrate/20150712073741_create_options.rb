class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :poll, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
