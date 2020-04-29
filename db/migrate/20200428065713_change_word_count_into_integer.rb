class ChangeWordCountIntoInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :essays, :word_count, :integer, using: 'word_count::integer'
  end
end
