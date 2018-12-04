class Post < ApplicationRecord
  validates :title, presence: true, bad_word: true
  validates :body, presence: true, bad_word: true

  before_create :generate_slug

  has_many :replies, dependent: :destroy

  private
    def generate_slug
      newSlug = self.title.parameterize

      while existing = Post.where(slug: newSlug).order(:created_at).take do
        if existing.slug[-1].to_i.to_s == existing.slug[-1].to_s then
          newSlug = self.title.parameterize + '-' + (existing.slug[-1].to_i + 1).to_s
        else
          newSlug = self.title.parameterize + '-2'
        end
      end

      self.slug = newSlug
    end

end
