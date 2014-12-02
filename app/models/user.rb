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

  before_create :check_idyllic_user
  @@id_users= nil

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password == password
      user
    else
      nil
    end
  end



#read csv from google drive
      
  def self.clear_cache
    @@id_users = nil
  end

  def self.get_cache
    return @@id_users
  end

  private
  def check_idyllic_user
    
    if @@id_users.nil? 
      session = GoogleDrive.login("bhosalekapil2015@gmail.com", "Kapil@1234")
      ws = session.spreadsheet_by_key("15mhoHOjO0kDFlkOhFlGX6mGUQ2QbziQu0nD8_pWwX1o").worksheets[0]
      arr = []
      arr << ws.rows
      arr.flatten!.delete_at(0)
      idyllic_users = arr
      @@id_users= idyllic_users
    end

    return true if @@id_users.include?(self.email)
    errors.add(:base, "Email is not registered to Idyllic")
    return false
  end

end
