class AddStoreIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :store, foreign_key: true
  end
end
