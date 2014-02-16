class Vote
  include Mongoid::Document

  belongs_to :comment
  belongs_to :user

  validates_uniqueness_of :user, :scope => :comment
  validates :value, inclusion: { in: [-1, 1] }

  field :value, type: Integer

  after_save :update_abusive

  private

  def update_abusive
    if comment.votes.sum(:value) == -3 and comment.marked_as_not_abusive == false
      comment.update_attribute :abusive, true
    end
  end
end