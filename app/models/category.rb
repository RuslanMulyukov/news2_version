class Category < ActiveRecord::Base
  belongs_to :user
  has_many :articles

  validates :title, :presence => true
  validates_uniqueness_of :title
  validates_length_of :title, :in => 3..30
end
