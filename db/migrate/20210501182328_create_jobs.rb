class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :employer
      t.string :location
      t.text :short_desc
      t.text :long_desc
      t.string :link
      t.string :source

      t.timestamps
    end
  end
end
