class CreateBeds < ActiveRecord::Migration
  def change
    create_table :beds do |t|
      t.string :number

      t.timestamps
    end
  end
end
