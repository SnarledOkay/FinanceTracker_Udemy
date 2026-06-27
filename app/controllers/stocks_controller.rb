class StocksController < ApplicationController
  def search
    if params[:stock].present?
      # @stock = Stock.new_lookup(params[:stock])
      @stock = Stock.new(ticker: params[:stock], company_name: "Microsoft", last_price: 275.3900)
      flash.now[:alert] = "Please enter a valid symbol to search" unless @stock
    else
      flash.now[:alert] = "Please enter a symbol to search"
    end
    respond_to do |format|
      format.turbo_stream
      format.html { render "users/my_portfolio" }
    end
  end
end
