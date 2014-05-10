class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :author_id
      t.string :author_name

      t.timestamps
    end
  end
end
