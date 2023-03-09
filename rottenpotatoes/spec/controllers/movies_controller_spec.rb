require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:all) do
    if Movie.where(:title => "Big Hero 6").empty?
      Movie.create(:title => "Big Hero 6", 
                   :rating => "PG", :release_date => "2014-11-07")
    end
    
    # TODO(student): add more movies to use for testing
    if Movie.where(:title => "Burgundy").empty?
      Movie.create(:title => "Burgundy", 
                   :rating => "PG", :release_date => "2002-10-02", :director => "Bandy")
    end

    if Movie.where(:title => "Burgundy2").empty?
      Movie.create(:title => "Burgundy2", 
                   :rating => "PG", :release_date => "2002-12-05", :director => "Bandy")
    end

    if Movie.where(:title => "Burgundy3").empty?
      Movie.create(:title => "Burgundy3", 
                   :rating => "PG", :release_date => "2002-11-03", :director => "Randy")
    end
  end
  
  describe "when trying to find movies by the same director" do
    it "returns a valid collection when a valid director is present" do
      # TODO(student): implement this test
      movie = Movie.find(2)
      get :show_by_director, params: { id: movie.id }
      expect(movie.director).to eq("Bandy")
      director = Movie.where(director: "Bandy")
      expect(director.count).to eq(2)
    end
    
    it "redirects to index with a warning when no director is present" do
      # TODO(student): implement this test
      movie = Movie.find(1)
      get :show_by_director, params: { id: movie.id }
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to match(/Director was not added to this movie./)

    end

  end
  
  describe "creates" do
    it "movies with valid parameters" do
      get :create, params: {:movie => {:title => "Toucan Play This Game", :director => "Armando Fox",
                    :rating => "G", :release_date => "2017-07-20"}}
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      Movie.find_by(:title => "Toucan Play This Game").destroy
    end
  end
  
  describe 'updates' do
    it "redirects to the movie details page and flashes a notice" do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { description: 'Critics rave about this epic new thriller. Watch as main characters Armando Fox ' \
                                                                 'and Michael Ball, alongside their team of TAs, battle against the challenges of ' \
                                                                 'a COVID-19-induced virtual semester, a labyrinthian and disconnected assignment ' \
                                                                 'stack, and the ultimate betrayal from their once-trusted ally: Codio exams.' } }

      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to match(/Outfoxed! was successfully updated./)
      movie.destroy
    end

    it "actually does the update" do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { director: 'Not Nick!' } }

      expect(assigns(:movie).director).to eq('Not Nick!')
      movie.destroy
    end
  end
end

