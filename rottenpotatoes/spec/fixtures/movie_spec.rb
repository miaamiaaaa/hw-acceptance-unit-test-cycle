require 'rails_helper'

describe Movie do
  fixtures :movies
  
  context 'movie has director info' do
    before :each do
      @memento   = movies(:memento)
      @inception = movies(:inception)
      @scarface  = movies(:scarface)
      @carrie    = movies(:carrie) 
    end
    it 'should find movies with the same director' do
      nolan_movies = Movie.find_by_same_director(@memento.id)
      depalma_movies = Movie.find_by_same_director(@scarface.id)
      expect(nolan_movies).to include @inception
      expect(depalma_movies).to include @carrie
    end
    it 'should not find movies by different directors' do
      depalma_movies = Movie.find_by_same_director(@scarface.id)
      expect(depalma_movies).not_to include @memento
      expect(depalma_movies).not_to include @inception
    end
  end
  context 'movie has *no director info' do
    it 'should raise exception if no director info found' do
      primer = movies(:primer)
      expect { Movie.find_by_same_director primer.id }.to raise_error(Movie::NoDirectorInfoFound)
    end
  end
end