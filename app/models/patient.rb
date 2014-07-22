class Patient < ActiveRecord::Base
  include PgSearch

  has_many :hospitalizations
  has_many :beds, through: :hospitalizations

  validates_presence_of :name, :sex, :birthdate

  pg_search_scope :search, against: [:name],
                  using: {tsearch: {dictionary: "portuguese"}},
                  ignoring: :accents

  def current_bed
    self.beds.where('hospitalizations.checkout is null').first
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end

end
