class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.get_movies_director(director)
      @director_movies = Movie.where(:director => director).pluck(:title)
      return @director_movies
  end
end