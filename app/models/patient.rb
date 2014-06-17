class Patient < ActiveRecord::Base
  has_many :hospitalizations
  has_many :beds, through: :hospitalizations

  def current_bed
    self.beds.where('hospitalizations.checkout is null').first
  end

end
