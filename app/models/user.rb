class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :name, :sex, :birthday, :email, :password, :password_confirmation, :remember_me

  has_many :articles
  has_many :categories
  has_many :votes
  has_many :comments

  has_attached_file :avatar, :styles => { :small => "150x150>" },
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates :login, :name, :presence => true
  validates_uniqueness_of :login
  validates_length_of :login, :in => 3..40
  validates_length_of :name, :in => 3..40
  validates_length_of :sex, :in => 2..6
end
