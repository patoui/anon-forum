class Tag < ApplicationRecord
  validates :name, presence: true, bad_word: true

  has_many :associations
  has_many :posts, through: :associations

  def self.popular
    self.left_outer_joins(:associations)
      .distinct
      .select('tags.*, COUNT(associations.tag_id) AS tag_count')
      .group('tag_id')
      .order('tag_count desc')
      .take(10)
  end
end
