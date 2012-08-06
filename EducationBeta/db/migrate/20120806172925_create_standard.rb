class CreateStandard < ActiveRecord::Migration
  def up
    create_table :standards do |t|
      t.string :name
      t.timestamps
    end

  end

  def down
    drop_table :standards
  end
end
