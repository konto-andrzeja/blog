class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    if comments.size < 3
      hotness = 0
    else
      hotness = 1
    end
    if created_at > 1.days.ago
      hotness + 3
    elsif created_at > 3.days.ago
      hotness + 2
    elsif created_at > 7.days.ago
      hotness + 1
    else
      hotness
    end
  end
end
