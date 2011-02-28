require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Users.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['users_id']
  end

  def test_create_valid
    Users.stubs(:authenticate).returns(Users.first)
    post :create
    assert_redirected_to root_url
    assert_equal Users.first.id, session['users_id']
  end
end
