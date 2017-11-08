class ChangueDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column_default :videos, :estado, false
    change_column_default :videos, :convirtiendo, false
  end
end
