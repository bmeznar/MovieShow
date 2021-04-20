class CreateTrailers < ActiveRecord::Migration[6.1]
  def change
    create_table :trailers do |t|
      t.string :videoId

      t.timestamps
    end
  end
end
