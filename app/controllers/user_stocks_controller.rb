class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      # stock = Stock.new_lookup(params[:ticker])
      stock = Stock.new(ticker: "NVDA", company_name: "Nvidia, Inc", last_price: 239.1100)
      stock.save()
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.company_name} has been added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    tracking_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    if tracking_stock.destroy
      flash[:notice] = "Stock #{stock.ticker} has been removed from your portfolio."
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to my_portfolio_path
  end
end
