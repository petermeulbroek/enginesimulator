class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.timestamp :time
      t.float :value

      t.timestamps
    end
  end
end
