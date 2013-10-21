class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  acts_as_taggable

  validates :title, presence: true,
    length: { minimum: 5 }
end
