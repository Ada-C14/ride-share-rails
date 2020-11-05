class ChangeRatingDatatype < ActiveRecord::Migration[6.0]
  def change
    change_column(:trips, :rating, "integer USING rating::integer")
  end
end
