class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
