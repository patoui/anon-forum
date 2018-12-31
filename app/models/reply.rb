class Reply < ApplicationRecord
  acts_as_paranoid

  validates :body, presence: true, bad_word: true

  before_create :generate_slug

  belongs_to :post

  private
  def generate_slug
    newSlug = 'reply-1'

    while existing = Reply.where(slug: newSlug, post_id: self.post_id).order(:created_at).first do
      if existing.slug[-1].to_s == existing.slug[-1].to_s then
        newSlug = 'reply-' + (existing.slug[-1].to_i + 1).to_s
      else
        newSlug = 'reply-2'
      end
    end

    self.slug = newSlug
  end
end
