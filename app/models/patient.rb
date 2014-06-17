class Patient < ActiveRecord::Base
  has_many :hospitalizations
end
