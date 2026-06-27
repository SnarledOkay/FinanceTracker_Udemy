class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :company_name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      quote = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
      overview = Alphavantage::Fundamental.new(symbol: ticker_symbol).overview
      new(ticker: ticker_symbol, company_name: overview.name, last_price: quote.price)
    rescue => exception
      Rails.logger.error "new_lookup error: #{exception.message}"
      nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
