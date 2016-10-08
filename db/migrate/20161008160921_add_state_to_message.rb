class AddStateToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :state, :integer, index: true
  end
end
