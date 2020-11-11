class Link < ApplicationRecord
  validates :url, presence: true
  validates :slug, uniqueness: true

  scope :frequent_links, -> { order(visited: :desc).limit(100) }

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  def self.generate_link(url)
    link = Link.new(url: url)
    return link unless link.valid?

    link.slug = SecureRandom.uuid[0..5]
    if link.save
      # run a background job here to get the title
      return link
    end
    Link.generate_link(url)
  end
end
