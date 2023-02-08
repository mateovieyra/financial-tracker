class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:publishable_token],
      secret_token: Rails.application.credentials.iex_client[:secret_token],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    quote = client.quote(ticker_symbol)
    company = client.company(ticker_symbol)
    new(name: company.company_name, ticker: ticker_symbol, last_price: quote.latest_price)
  end
end
