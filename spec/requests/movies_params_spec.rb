require 'rails_helper'

RSpec.describe 'Movies params', type: :request do
  it 'permits director on create' do
    post '/movies',
         { 'movie' => {
             'title' => 'New',
             'rating' => 'PG',
             'director' => 'Some One',
             'release_date' => '2000-01-01'
           } }

    m = Movie.find_by(title: 'New')
    expect(m&.director).to eq('Some One')
    expect(response).to redirect_to(movies_path)
  end

  it 'permits director on update' do
    m = Movie.create!('title' => 'EditMe', 'rating' => 'PG', 'director' => 'Old', 'release_date' => '2000-01-01')

    patch "/movies/#{m.id}",
          { 'movie' => { 'director' => 'New' } }

    expect(m.reload.director).to eq('New')
    expect(response).to redirect_to(movie_path(m))
  end
end
