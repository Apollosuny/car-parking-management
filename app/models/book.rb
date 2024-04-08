class Book < ApplicationRecord
  belongs_to :subject

  validates_presence_of :title, :author
  validates_uniqueness_of :title
  validates_numericality_of :year
end
