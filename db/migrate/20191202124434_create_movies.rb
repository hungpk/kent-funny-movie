class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.text :title
      t.text :video_id      
      t.text :description
      t.belongs_to :user
      t.timestamps
    end
  end
end
