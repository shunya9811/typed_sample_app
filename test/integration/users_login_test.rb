require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # メールアドレスが正しくてパスワードが誤っている場合をテストする
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with invalid inforamtion" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: "", passward: ""}}
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    #ログイン用のパスを開く
    #セッション用パスに有効な情報をPOSTする
    post login_path, params: {session: {email: @user.email, password: 'password'}}
    #リダイレクト先が正しいかチェックして実際に移動
    assert_redirected_to @user
    follow_redirect!
    #ログイン用リンクが表示されなくなったことを確認する
    assert_select "a[href=?]", login_path, count: 0    
    #ログアウト用リンクが表示されていることを確認する
    assert_select "a[href=?]", logout_path
    #プロフィール用リンクが表示されていることを確認する
    assert_select "a[href=?]", user_path(@user)
  end 
end
