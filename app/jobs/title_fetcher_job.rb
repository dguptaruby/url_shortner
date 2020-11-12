class TitleFetcherJob < ApplicationJob
  queue_as :default

  def perform(link_id)
    link = Link.find_by(id: link_id)
    return unless link

    url = link.url
    response = HTTParty.get(url)
    link.title = Nokogiri::HTML::Document.parse(response.body).title
    link.save
  end
end
