class CreateDocument1s < ActiveRecord::Migration[7.2]
  def change
    create_table :document1s do |t|
      t.string :title

      t.timestamps
    end
  end
end
