class Url < ApplicationRecord
  validates :original_url, presence: true, format: { with: /\A(http|https):\/\/[^\s$.?#].[^\s]*\z/i, message: "must start with 'http://' or 'https://'" }

  before_create :set_expiration_date

  def to_param
    short_url
  end

  private

  DEFAULT_EXPIRATION_PERIOD = 5.minute

  def set_expiration_date
    self.expires_at ||= Time.current + DEFAULT_EXPIRATION_PERIOD
  end
end
