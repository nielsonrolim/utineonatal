class Bed < ActiveRecord::Base
  has_many :hospitalizations;
end
