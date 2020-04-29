class CreateEssays < ActiveRecord::Migration[5.2]
  def change
    create_table :essays do |t|

      t.timestamps
    end
  end
end
