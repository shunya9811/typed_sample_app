class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:sessions][:passward])
      # ユーザーログイン後のユーザー情報ページにリダイレクトする
    else
      flash.now[:danger] = 'Invalid email/passward combination' # 本当は正しくない
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end
