class Reply < ApplicationRecord
  validates :body, presence: true, bad_word: true

  belongs_to :post
end
