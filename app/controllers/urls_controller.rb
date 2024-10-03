class UrlsController < ApplicationController
  before_action :set_url, only: [:show]

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.short_url = generate_unique_short_url

    if @url.save
      redirect_to urls_path, notice: 'Short URL was successfully created.'
    else
      flash.now[:alert] = @url.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    result = UrlRedirector.new(@url).perform

    case result[:status]
    when :redirect
      redirect_to result[:destination], allow_other_host: true
    when :expired
      render plain: "This short URL has expired.", status: :gone
    end
  end

  private

  def set_url
    @url = Url.find_by(short_url: params[:id])

    # If URL is not found, raise an error or handle it
    unless @url
      render plain: "Short URL not found", status: :not_found
    end
  end

  def url_params
    params.require(:url).permit(:original_url)
  end

  def generate_unique_short_url
    loop do
      short_url = SecureRandom.alphanumeric(6) # Generates a random 6-character alphanumeric string
      break short_url unless Url.exists?(short_url: short_url)
    end
  end
end
