class ChangeStateTypeFormIntToString < ActiveRecord::Migration
  def up
    change_column :stories, :state, :string
  end

  def down
    change_column :stories, :state, :integer
  end
end
