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
    Digest::MD5.hexdigest("#{@url.original_url}-#{Time.current.to_i}")[0, 6]
  end
end
