class Movie < ActiveRecord::Base
    def self.all_ratings
        {'G'=>false, 'PG'=>false, 'PG-13'=>false, 'R'=>false}
    end 
end
