class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  validates_presence_of :body

  belongs_to :user
  belongs_to :post
  has_many :votes
end