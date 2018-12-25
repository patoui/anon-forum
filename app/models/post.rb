class Post < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true, bad_word: true
  validates :body, presence: true, bad_word: true

  before_create :generate_slug

  has_many :replies, dependent: :destroy
  has_many :associations
  has_many :tags, through: :associations

  def addTags(items)
    if items.kind_of?(Array)
      items.each do |item|
        tag = Tag.find_or_create_by(name: item)
        self.associations.find_or_create_by(tag_id: tag.id)
      end
    end
  end

  def self.search(q)
    posts = self.includes(:tags)
    tags = []

    if q
      tags = q.scan(/(#[a-zA-Z0-9]+)/).flatten
      tags.each { |tag| q = q.gsub(tag, '') }
      q = q.strip
      if q.length > 0
        posts = posts.where('title LIKE ?', "%#{q}%")
      end
      tags = tags.map{ |tag| tag.gsub('#', '') }
    end

    if tags.length > 0
      posts = posts.where('tags.name': tags)
    end

    return posts
  end

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
