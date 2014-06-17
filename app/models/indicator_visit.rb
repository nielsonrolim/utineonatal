class IndicatorVisit < ActiveRecord::Base
  belongs_to :indicator
  belongs_to :visit
end
