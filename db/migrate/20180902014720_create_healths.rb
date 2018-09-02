class CreateHealths < ActiveRecord::Migration[5.2]
  def change
    create_table :healths do |t|
      t.timestamp :time
      t.boolean :value

      t.timestamps
    end
  end
end
