class ChangePhoneNumberColumnNameInPassengers < ActiveRecord::Migration[6.0]
  def change
    rename_column :passengers, :phone_number, :phone_num
  end
end
