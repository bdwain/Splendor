class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :trackable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :confirmable, :validatable

  #has_many :players, :inverse_of => :user
                  
  validates :displayname, :presence => true, 
            :length => {:minimum => 3, :maximum => 20}

end
