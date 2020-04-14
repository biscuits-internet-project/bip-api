class ChangeReviewsToBelongToShow < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :show, type: :uuid
    remove_column :reviews, :reviewable_id
    remove_column :reviews, :reviewable_type
  end
end
