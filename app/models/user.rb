class User < ApplicationRecord
  has_secure_password
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
