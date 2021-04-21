class AddTitleToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :movie_id, :string
    add_column :movies, :title, :string
    add_column :movies, :release_date, :string
    add_column :movies, :backdrop_path, :text
    add_column :movies, :poster_path, :text
    add_column :movies, :overview, :text
    add_column :movies, :average_vote, :float
    add_column :movies, :buget, :integer
    add_column :movies, :tegline, :text
    add_column :movies, :runtime, :integer
  end
end
