require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#others_by_same_director' do
    it 'returns movies with same director, excluding self' do
      lucas1 = Movie.create!(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: '1971-03-11')
      lucas2 = Movie.create!(title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: '1977-05-25')
      scott  = Movie.create!(title: 'Blade Runner', rating: 'PG', director: 'Ridley Scott', release_date: '1982-06-25')

      expect(lucas2.others_by_same_director).to contain_exactly(lucas1)
      expect(scott.others_by_same_director).to be_empty
    end

    it 'returns none when director is blank' do
      movie = Movie.create!(title: 'Alien', rating: 'R', director: '', release_date: '1979-05-25')
      expect(movie.others_by_same_director).to be_empty
    end
  end
end
