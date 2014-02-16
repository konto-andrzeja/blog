class Vote
  include Mongoid::Document

  belongs_to :comment

  validates :value, inclusion: { in: [-1, 1] }

  field :value, type: Integer

  after_save :update_abusive

  private

  def update_abusive
    if comment.votes.sum(:value) == -3
      comment.update_attribute :abusive, true
    end
  end
end