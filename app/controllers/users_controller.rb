class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends 
    @my_friends = current_user.friends
  end

  def search 
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @my_friends = current_user.friends
      if @friends
        @friends = @friends.select {|friend| current_user.id != friend.id}
        render "users/my_friends"
      else
        flash[:alert] = "No friends found"
        redirect_to my_friends_path
      end
    else
      flash[:alert] = "Please enter a name or email to search"
      redirect_to my_friends_path
    end
  end

  def show 
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
