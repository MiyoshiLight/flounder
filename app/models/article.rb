class Article < ApplicationRecord
  has_many_attached :files

  validates :title, presence: true
end
