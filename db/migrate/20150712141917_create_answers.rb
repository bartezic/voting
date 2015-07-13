class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :option, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.inet :ip

      t.timestamps null: false
    end
  end
end
