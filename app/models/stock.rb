class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:publishable_token],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      new(name: client.company(ticker_symbol).company_name, ticker: ticker_symbol, last_price: client.quote(ticker_symbol).latest_price)
    rescue => exception
      nil
    end
  end

  def self.check_db(ticker_symbol) 
    where(ticker: ticker_symbol).first
  end
end
