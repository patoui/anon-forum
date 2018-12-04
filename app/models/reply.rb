class Reply < ApplicationRecord
  validates :body, presence: true
  validate :validate_bad_words

  belongs_to :post

  def validate_bad_words
    cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 90.minutes)
    bad_words = cache.fetch('bad_words') do
      File.readlines('repos/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/en').map { |a| a.strip }
    end
    body_array = self.body.gsub(/[^0-9a-z ]/i, '').split
    for word in body_array
      if bad_words.include? word
        errors.add(:body, 'The body must not contain bad words.')
        break
      end
    end
  end
end
