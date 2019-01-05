class Reply < ApplicationRecord
  acts_as_paranoid

  validates :body, presence: true, bad_word: true

  before_create :generate_slug

  belongs_to :post

  private
  def generate_slug
    newSlug = SecureRandom.hex 3

    while existing = Reply.where(slug: newSlug, post_id: self.post_id).first do
      newSlug = SecureRandom.hex 3
    end

    self.slug = newSlug
  end
end
