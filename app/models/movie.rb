class Movie < ActiveRecord::Base
  def self.allratings
    ['G', 'PG', 'PG-13', 'R']
  end
end
