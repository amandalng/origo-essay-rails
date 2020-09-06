class ChangeEssaysColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :essays, :spam, false
  end
end
