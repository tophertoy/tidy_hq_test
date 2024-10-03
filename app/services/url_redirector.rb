class UrlRedirector
  def initialize(url)
    @url = url
  end

  def perform
    if active?
      increment_click_count
      { status: :redirect, destination: @url.original_url }
    else
      { status: :expired }
    end
  end

  private

  def active?
    @url.expires_at > Time.current
  end

  def increment_click_count
    @url.increment!(:click_count)
  end
end
