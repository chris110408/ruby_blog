class Article < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :description
  validates :user_id,presence: true
end
