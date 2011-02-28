require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  def new_users(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    users = Users.new(attributes)
    users.valid? # run validations
    users
  end

  def setup
    Users.delete_all
  end

  def test_valid
    assert new_users.valid?
  end

  def test_require_username
    assert new_users(:username => '').errors.on(:username)
  end

  def test_require_password
    assert new_users(:password => '').errors.on(:password)
  end

  def test_require_well_formed_email
    assert new_users(:email => 'foo@bar@example.com').errors.on(:email)
  end

  def test_validate_uniqueness_of_email
    new_users(:email => 'bar@example.com').save!
    assert new_users(:email => 'bar@example.com').errors.on(:email)
  end

  def test_validate_uniqueness_of_username
    new_users(:username => 'uniquename').save!
    assert new_users(:username => 'uniquename').errors.on(:username)
  end

  def test_validate_odd_characters_in_username
    assert new_users(:username => 'odd ^&(@)').errors.on(:username)
  end

  def test_validate_password_length
    assert new_users(:password => 'bad').errors.on(:password)
  end

  def test_require_matching_password_confirmation
    assert new_users(:password_confirmation => 'nonmatching').errors.on(:password)
  end

  def test_generate_password_hash_and_salt_on_create
    users = new_users
    users.save!
    assert users.password_hash
    assert users.password_salt
  end

  def test_authenticate_by_username
    Users.delete_all
    users = new_users(:username => 'foobar', :password => 'secret')
    users.save!
    assert_equal users, Users.authenticate('foobar', 'secret')
  end

  def test_authenticate_by_email
    Users.delete_all
    users = new_users(:email => 'foo@bar.com', :password => 'secret')
    users.save!
    assert_equal users, Users.authenticate('foo@bar.com', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil Users.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    Users.delete_all
    new_users(:username => 'foobar', :password => 'secret').save!
    assert_nil Users.authenticate('foobar', 'badpassword')
  end
end
