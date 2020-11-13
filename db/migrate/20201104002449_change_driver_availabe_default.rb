class ChangeDriverAvailabeDefault < ActiveRecord::Migration[6.0]
  def up
    change_column_default :drivers, :available, true
  end

  def down
    change_column_default :drivers, :available, nil
  end
end
