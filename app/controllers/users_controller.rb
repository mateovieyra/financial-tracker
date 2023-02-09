class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends 
    @my_friends = current_user.friends
  end

  def search 
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = @friends.select {|friend| current_user.id != friend.id}
      @my_friends = current_user.friends
      if @friends
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
end
