class Tag < ApplicationRecord
  validates :name, presence: true, bad_word: true

  has_and_belongs_to_many :posts, -> { distinct }
end
