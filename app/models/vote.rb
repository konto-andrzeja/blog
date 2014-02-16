class Vote
  include Mongoid::Document

  belongs_to :comment

  validates :value, inclusion: { in: [-1, 1] }

  field :value, type: Integer
end