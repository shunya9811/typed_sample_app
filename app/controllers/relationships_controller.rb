class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    # インスタンス変数がTurboの実装で必要になる
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    # インスタンス変数がTurboの実装で必要になる
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end
end
