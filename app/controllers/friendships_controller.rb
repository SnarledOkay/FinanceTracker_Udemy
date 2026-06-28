class FriendshipsController < ApplicationController
  def create
    exist_friendship = Friendship.where(user_id: current_user.id, friend_id: params[:friend_id]).first
    if exist_friendship
      flash[:alert] = "You have already followed this user."
    else
      Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
      flash[:notice] = "User has been added to your follow list."
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "User has been removed from your friend list."
    redirect_to my_friends_path
  end
end
