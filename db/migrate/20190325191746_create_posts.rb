class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.cidr :ip
      t.string :title
      t.text :body
      t.float :avg_rating, precision: 4, scale: 3, default: 0
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    add_index :posts, %i[avg_rating created_at], order: { avg_rating: :desc, created_at: :desc }
  end
end
