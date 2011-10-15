class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :role
  validates :username, :presence => true, :length => { :minimum => 5} , :uniqueness => true
  validates :email, :presence => true, :uniqueness => true, :length => { :within => 5..50 }, :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validates :crypted_password, :presence => true
  validates :password_salt, :presence => true
  validates :role_id, :presence => true

  def role?(rolename)
    role.rolename == rolename.to_s
  end
end
