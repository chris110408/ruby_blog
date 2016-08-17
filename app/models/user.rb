class User < ActiveRecord::Base
  has_many :comments
  has_many :articles

  before_save { self.email = email.downcase}

  EMAIL_REGEX = /\A[a-z0-9.%+-]+@[a-z]+\.[a-z]{2,4}\Z/i

  validates :username, presence:true, uniqueness:{case_sensitive: false}, length:{:minimum => 3, :maximum => 25}
  validates :email,  presence:true, uniqueness:{case_sensitive: false}, length:{:minimum => 3, :maximum => 105},
            :format =>EMAIL_REGEX

end
