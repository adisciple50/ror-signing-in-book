class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.text :name
      t.datetime :time_in
      t.datetime :time_out
      t.string :mobile_phone

      t.timestamps
    end
  end
end
