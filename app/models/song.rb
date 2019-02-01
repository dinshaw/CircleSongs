class Song < ApplicationRecord
  has_many :recordings
  accepts_nested_attributes_for :recordings
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :categories

  def formatted_chords
    @formatted_chords ||= Chordpro.html(chords)
  end
end
