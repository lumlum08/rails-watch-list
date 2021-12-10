# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
require 'faker'
puts "Cleaning database..."
Movie.destroy_all
puts "Creating movies..."
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies_url = 'http://tmdb.lewagon.com/movie/top_rated'
  base_poster_url = 'https:image.tmdb.org/t/p/original'
  movies = JSON.parse(open("#{movies_url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    if movie['original_language'] == 'en'
      puts "Creating #{movie['title']}..."
      Movie.create(
        title: movie['title'],
        overview: movie['overview'],
        poster_url: "#{base_poster_url}#{movie['poster_path']}",
        rating: movie['vote_average']
      )
    end
  end
end
puts 'Creating lists...'
genres = %w[Action Classic Comedy Drama Fantasy Romance]
genres.each do |genre|
  list = List.create!(name: genre.upcase!)
  puts "Creating #{list['name']}..."
end
# 10.times do |i|
#   list = List.create!(name: "#{i+1}. #{Faker::Movies::LordOfTheRings.location}")
#   puts "Creating #{list['name']}..."
# end
puts "Creating bookmarks..."
50.times do
  bookmark = Bookmark.create!(
    comment: "#{Faker::Movie.quote}",
    movie_id: rand(Movie.first.id..Movie.last.id),
    list_id: rand(List.first.id..List.last.id)
  )
  puts "Creating bookmark #{bookmark['comment']}..."
end
puts "Finished seeding!"
