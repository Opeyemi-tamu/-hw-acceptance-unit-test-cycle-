require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:all) do
    if Movie.where(title: 'Big Hero 6').empty?
      Movie.create(title: 'Big Hero 6',
                   rating: 'PG', release_date: '2014-11-07')
    end

    # TODO(student): add more movies to use for testing
    if Movie.where(title: 'Burgundy').empty?
      Movie.create(title: 'Burgundy',
                   rating: 'PG', release_date: '2002-10-02', director: 'Bandy')
    end

    if Movie.where(title: 'Burgundy2').empty?
      Movie.create(title: 'Burgundy2',
                   rating: 'PG', release_date: '2002-12-05', director: 'Bandy')
    end

    if Movie.where(title: 'Burgundy3').empty?
      Movie.create(title: 'Burgundy3',
                   rating: 'PG', release_date: '2002-11-03', director: 'Randy')
    end
  end

  describe 'others_by_same_director method' do
    it 'returns all other movies by the same director' do
      # TODO(student): implement this test
      movie = Movie.where(director: 'Bandy')
      expect(movie.count).to eq(2)
    end

    it 'does not return movies by other directors' do
      director = 'Bandy'
      # TODO(student): implement this test
      movie = Movie.where(director: 'Bandy')
      expect(movie.pluck(:director).uniq).to eq([director])
    end
  end
end
