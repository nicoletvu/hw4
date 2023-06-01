class SessionsController < ApplicationController
  def new
    # renders login form in sessions/new.html.erb
  end

  def create
    @user = User.find_by({"username" => params["username"]})
    if @user != nil  
      if BCrypt::Password.new(@user["password"]) == params["password"] 
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/places"
      else 
        flash["notice"] = "Sorry, your login credentials were incorrect. Please try again."
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "Sorry, we can't find a user with that username. Please try again."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "See you later!"
    redirect_to "/sessions/new"
  end
end
  