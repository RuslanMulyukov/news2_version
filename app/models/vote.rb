class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :result, :presence => true

  scope :for, :conditions => { :result => 'for' }
  scope :against, :conditions => { :result => 'against' }
end

