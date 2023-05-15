class UsersController < ApplicationController
  # GET /users/:id
  def show
    @user = User.find(params[:id])
    # => app/views/users/show.html.erb
  end

  # GET /users/new
  def new
    # => app/views/users/new.html.erb
  end
end
