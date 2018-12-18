class Reply < ApplicationRecord
  acts_as_paranoid

  validates :body, presence: true, bad_word: true

  belongs_to :post
end
