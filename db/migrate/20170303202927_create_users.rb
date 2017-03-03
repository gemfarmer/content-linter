class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :github_id
      t.timestamps null: false
    end
  end
end
