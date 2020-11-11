class LinksController < ApplicationController
  def show
    @link = Link.find_by_slug(params[:slug])
    if @link.nil?
      render file: 'public/404.html', status: :not_found, layout: false
    else
      @link.update_attribute(:visited, @link.visited + 1)
      redirect_to @link.url
    end
  end

  def new
    @link = Link.new
  end

  def index
    @frequent_links = Link.frequent_links
  end

  def create
    @link = Link.generate_link(link_params[:url])
    if @link.save
      @frequent_links = Link.frequent_links
      flash[:notice] = 'You have successfully shortened URL.'
      render :index
    else
      render 'new'
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
