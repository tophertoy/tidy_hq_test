class ShortUrlGenerator
  def initialize(url)
    @url = url
  end

  def perform
    @url.short_url = unique_short_url
    @url
  end

  private

  def unique_short_url
    loop do
      short_url = SecureRandom.alphanumeric(6)
      break short_url unless Url.exists?(short_url: short_url)
    end
  end
end
