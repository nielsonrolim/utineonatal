class Patient < ActiveRecord::Base
  has_many :hospitalizations
  has_many :beds, through: :hospitalizations

  def current_bed
    self.beds.where('hospitalizations.datahora_saida is null')
  end

end
