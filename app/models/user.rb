class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    first_name || last_name ? "#{first_name} #{last_name}" : "Anonymous"
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def self.find_matches(user_info)
    search_term = "%#{user_info.strip}%"
    where("LOWER(email) LIKE :search or LOWER(first_name) LIKE :search or LOWER(last_name) LIKE :search", search: search_term)
  end
end
