class Article < ApplicationRecord
  has_many_attached :files

  validates :title, presence: true

  def attached_images
    files.select(&:image?)
  end

  def attached_documents
    files.reject(&:image?)
  end

  def thumbnail_image
    return nil unless files.attached?

    files.detect(&:image?)
  end

  def files_count
    files.attached? ? files.size : 0
  end
end
