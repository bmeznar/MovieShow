# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
movie_seed = JSON.parse(RestClient.get("https://api.themoviedb.org/3/movie/popular?api_key=#{ENV["MOVIE_API_KEY"]}&page=1"))
movie_seed['results'].each do |movie|
  Movie.where(
    movie_id: movie['id'],
    title: movie['title'],
    release_date: movie['release_date'],
    poster_path: movie['poster_path'],
    backdrop_path: movie['backdrop_path'],
    overview: movie['overview'],
    average_vote: movie['vote_average']
  ).first_or_create
end

trailer_seed = JSON.parse(RestClient.get("https://youtube.googleapis.com/youtube/v3/search?channelId=UCT0hbLDa-unWsnZ6Rjzkfug&key=#{ENV["YOUTUBE_API_KEY"]}"))
trailer_seed['items'].each do |trailer|
  Trailer.where(
    videoId: trailer['id']['videoId']
  ).first_or_create
end