class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    @found_users = []
    if params[:friend_info].present?
      @found_users = User.find_matches(params[:friend_info])
      @found_users = current_user.except_current_user(@found_users)
    else
      flash.now[:alert] = "Please enter a name or email to search."
    end
    respond_to do |format|
      format.turbo_stream
      format.html { render "users/my_portfolio" }
    end
  end
end
