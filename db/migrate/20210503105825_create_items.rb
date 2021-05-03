class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.references :job, null: false, foreign_key: true, type: :bigint
      t.string :status

      t.timestamps
    end
  end
end
