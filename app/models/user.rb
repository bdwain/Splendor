class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :trackable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :confirmable, :validatable

  #has_many :players, :inverse_of => :user
                  
  validates :displayname, :presence => true, 
            :length => {:minimum => 3, :maximum => 20}

end
