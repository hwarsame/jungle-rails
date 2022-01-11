class CreateInvokes < ActiveRecord::Migration
  def change
    create_table :invokes do |t|
      t.string :active_record

      t.timestamps null: false
    end
  end
end
