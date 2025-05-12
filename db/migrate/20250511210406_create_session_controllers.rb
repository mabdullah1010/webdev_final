class CreateSessionControllers < ActiveRecord::Migration[7.2]
  def change
    create_table :session_controllers do |t|
      t.string :Session

      t.timestamps
    end
  end
end
