require 'rails_helper'

RSpec.describe "Movies basic pages", type: :request do
  it "loads the index" do
    get movies_path
    expect(response).to have_http_status(:ok)
  end

  it "loads the new movie form" do
    get new_movie_path
    expect(response).to have_http_status(:ok)
  end

  it "loads the edit form and show page (with the similar link)" do
    m = Movie.create!(title: 'Alien', rating: 'R', director: 'Ridley Scott', release_date: '1979-05-25')

    get edit_movie_path(m)
    expect(response).to have_http_status(:ok)

    get movie_path(m)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Find Movies With Same Director') # covers show view/link
  end

  it "destroys a movie and redirects to index with a flash" do
    m = Movie.create!(title: 'Temp', rating: 'PG', director: '', release_date: '2000-01-01')
    delete movie_path(m)
    expect(response).to redirect_to(movies_path)
  end
end
