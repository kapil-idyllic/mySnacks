class User < ActiveRecord::Base
  # before_save :encrypt_password
  # after_save :clear_password
  #
  # def encrypt_password
  #   if password.present?
  #     self.salt = BCrypt::Engine.generate_salt
  #     self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
  #   end
  # end
  #
  # def clear_password
  #   self.password = nil
  # end
  validates :email, uniqueness: true


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end

end
