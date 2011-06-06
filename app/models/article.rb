class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :votes
  has_many :comments

  validates :title, :description, :presence => true
  validates_uniqueness_of :title
  validates_length_of :title, :in => 5..150

  scope :recent, order('created_at DESC')

  class << self
    def by_max_rating
      all.sort { |a, b| b.votes.for <=> a.votes.for }
    end

    def by_min_rating
      all.sort { |a, b| a.votes.for <=> b.votes.for }
    end
  end
end

