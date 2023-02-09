class FriendshipsController < ApplicationController

  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend])
    flash[:notice] = "Friend was succesfully added to your friends."
    redirect_to my_friends_path
  end

  def destroy 
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    friendship.destroy 
    flash[:notice] = "Friend was succesfully remove to your friends."
    redirect_to my_friends_path
  end
end
