require 'rails_helper'

RSpec.describe 'Similar Movies', type: :request do
  describe 'GET /movies/:id/same_director' do
    it 'lists movies with the same director (happy path)' do
      lucas  = Movie.create!(title: 'Star Wars',  rating: 'PG', director: 'George Lucas', release_date: '1977-05-25')
      _thx   = Movie.create!(title: 'THX-1138',   rating: 'R',  director: 'George Lucas', release_date: '1971-03-11')
      _alien = Movie.create!(title: 'Alien',      rating: 'R',  director: 'Ridley Scott', release_date: '1979-05-25')

      get same_director_movie_path(lucas)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('THX-1138')
      expect(response.body).not_to include('Alien')
    end

    it 'redirects to index with a flash when director is missing (sad path)' do
      alien = Movie.create!(title: 'Alien', rating: 'R', director: '', release_date: '1979-05-25')

      get same_director_movie_path(alien)
      expect(response).to redirect_to(movies_path)

      follow_redirect!
      # Accept raw or HTML-escaped quotes
      expect(response.body).to match(/(?:'|&#39;)Alien(?:'|&#39;)\s+has no director info/)
    end
  end
end
